<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Http\Resources\EventResource;
use App\Models\Event;
use App\Models\EventSuggestion;
use App\Models\Suggestion;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use GuzzleHttp\Client;

class EventController extends Controller
{
    public function index()
    {
        $user = User::orderBy('created_at', 'desc')->first();

        return Event::where('user_id', $user->id)->get();
    }

  public function store(Request $request)
  {
    $user = User::orderBy('created_at', 'desc')->first();

    $event = new Event();
    $event->fill($request->all());
    $event->user_id = $user->id;
    $event->save();

    $client = new Client();
    $apiKey = env('GOOGLE_API_KEY');
    $url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=' . $apiKey;

    $eventTitle = $event->title;
    $eventDescription = $event->description;
    $eventStartDate = $event->start_date;
    $eventEndDate = $event->end_date;
    $text = "Você é uma agenda automática com IA, seu dever é ler as descrições dos eventos e sugerir melhorias. ";
    $text .= "Você foi designado para analisar um evento específico e sugerir uma melhoria para ele. ";
    $text .= "Esses eventos são na verdade itens na agenda de um ser humano ";
    $text .= "e você deve ajudar a melhorar a experiência deles. ";
    $text .= "Por exemplo: : Se o usuário criar um item que deve estudar para uma prova, hoje às 21:00, o aplicativo irá criar itens de sugestão dentro do escopo do compromisso como:";
    $text .= "1. Estudar por 1 hora.";
    $text .= "Aqui está o evento que você deve analisar: ";
    $text .= "Título do evento: $eventTitle. ";
    $text .= "Descrição do evento: $eventDescription. ";
    $text .= "Data de início: $eventStartDate. ";
    $text .= "Data de término: $eventEndDate. ";
    $text .= "Baseado nas informações fornecidas, sugira um item na agenda para melhorar este evento no futuro. ";
    $text .= "Leve em consideração todos os detalhes fornecidos sobre o evento. ";
    $text .= "Por favor, responda no seguinte formato: ";
    $text .= "{'title': '[Título da sugestão]', 'description': '[Descrição da sugestão]'}. ";
    $text .= "Tente ser o mais coeso possível e envie três sugestões diferentes, no formato que pedi. ";
    $text .= "Por favor, não envie nenbhum texto fora do formato que lhe pedi para evitar problemas ";
    $text .= "Tente pensar em sugestões que sejam úteis para o usuário e que melhorem a experiência dele. ";
    $text .= "evite dar sugestões muito óbvias que o usuário poderia pensar sozinho, mas mantenha o respeito e a educação. ";
    $text .= "Você deve evitar ao máximo dar sugestões que contenham conteúdo sexualmente explícito, discurso de ódio, assédio ou conteúdo perigoso. ";
    $text .= "Por favor, responda em português.";
    $params = [
        "contents" => [
            [
                "role" => "user",
                "parts" => [
                    ["text" => $text]
                ]
            ],
        ]
    ];

    try {
        $response = $client->post($url, [
            'headers' => [
                'Content-Type' => 'application/json',
            ],
            'json' => $params,
        ]);
        $responseBody = json_decode($response->getBody(), true);

        $rawText = $responseBody['candidates'][0]['content']['parts'][0]['text'];
        
        $rawJson = trim($rawText, " \t\n\r\0\x0B`json");
        
        $rawJson = str_replace("'", '"', $rawJson);
        $suggestions = json_decode($rawJson, true);

        $suggestion1 = $suggestions[0];
        $suggestion2 = $suggestions[1];
        $suggestion3 = $suggestions[2];

        $suggestio1Db = Suggestion::create([
            'title' => $suggestion1['title'],
            'description' => $suggestion1['description'],
        ]);

        $suggestion2Db = Suggestion::create([
            'title' => $suggestion2['title'],
            'description' => $suggestion2['description'],
        ]);

        $suggestion3Db = Suggestion::create([
            'title' => $suggestion3['title'],
            'description' => $suggestion3['description'],
        ]);

        $event->refresh();

        EventSuggestion::create([
            'event_id' => $event->id,
            'suggestion_id' => $suggestio1Db->id,
        ]);

        EventSuggestion::create([
            'event_id' => $event->id,
            'suggestion_id' => $suggestion2Db->id,
        ]);

        EventSuggestion::create([
            'event_id' => $event->id,
            'suggestion_id' => $suggestion3Db->id,
        ]);

        return response()->json([
            'event' => $event,
        ]);

    } catch (\Exception $e) {
        return response()->json(['error' => $e->getMessage()], 500);
    }
    }

    public function show(Event $event)
    {
        $event->load('eventSuggestion.suggestion');
        return EventResource::make($event);
    }

    public function destroy(Event $event)
    {
        $event->delete();
    
        return response()->noContent();
    }
}
