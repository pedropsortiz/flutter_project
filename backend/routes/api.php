<?php

use App\Http\Middleware\TrackApiRequest;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\EventController;

Route::middleware('throttle:api')->group(function () {
    Route::middleware(['auth:sanctum', TrackApiRequest::class])->group(function () {
        Route::post('logout', [AuthController::class, 'logout']);
        Route::apiResource('events', EventController::class)->parameters([
            'events' => 'event'
    ]);

    Route::post('login', [AuthController::class, 'login']);
    Route::post('signup', [AuthController::class, 'register']);

});
});
