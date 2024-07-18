<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\EventController;
use Illuminate\Support\Facades\Route;


Route::middleware('auth:sanctum')->group(function () {
    Route::post('login', [AuthController::class, 'login']);
    Route::post('signup', [AuthController::class, 'signup']);
    Route::post('logout', [AuthController::class, 'logout']);

    Route::apiResource('events', EventController::class)->parameters([
        'events' => 'event'
    ]);
});

/*
add item 
 --aq fazer pesquisa e savar nas sugestoes tabela
show item
index itens

--- update fodase 
*/