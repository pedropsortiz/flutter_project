<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SuggestionResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $suggestion = $this->suggestion;    
        return [
            'id' => $suggestion->id,
            'title' => $suggestion->title,
            'description' => $suggestion->description,
        ];
    }
}
