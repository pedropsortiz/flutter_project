<?php

namespace App\Http\Controllers;

use App\Http\Requests\SignUpRequest;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request_values = $request->only('email', 'password');

        $credentials = [
            'email' => $request_values['email'],
            'password' => $request_values['password'],
        ];

        if (Auth::attempt($credentials)) {
            $user = Auth::user();
            $user_id = Auth::id();
            Auth::login($user);

            $token = $user->createToken('auth-token')->plainTextToken;
            $cookie = cookie('jwt', $token, 60 * 24);

            return response()->json([
                'access_token' => $token,
                'user_id' => $user_id,
            ])->withCookie($cookie);
        }

        return redirect()->intended('dashboard');
    }

    public function signup(SignUpRequest $request)
    {
        $user = new User([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
        ]);

        $user->save();

        return redirect()->intended('/');
    }

    public function logout(Request $request)
    {
        $authUser = Auth::user();
        dd($authUser);
        Auth::logout();

        $cookie = cookie()->forget('jwt');

        return redirect()->intended('/')->withCookie($cookie);
    }
}
