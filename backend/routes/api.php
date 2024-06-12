<?php

use App\Http\Controllers\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


Route::middleware('throttle:api')->group(function () {
    Route::get('login', [AuthController::class, 'login']);
    Route::post('signup', [AuthController::class, 'signup']);
});