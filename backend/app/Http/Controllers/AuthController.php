<?php

namespace App\Http\Controllers;

use App\Http\Requests\SignUpRequest;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function login(Request $request){
        try {
            $loginUserData = $request->validate([
                'email'=>'required|string|email',
                'password'=>'required'
            ]);
            $user = User::where('email',$loginUserData['email'])->first();
            if(!$user || !Hash::check($loginUserData['password'],$user->password)){
                return response()->json([
                    'message' => 'Invalid Credentials'
                ],401);
            }
            $token = $user->createToken($user->name.'-AuthToken')->plainTextToken;
            Auth::login($user);
            Auth::guard('web')->login($user);
            return response()->json([
                'access_token' => $token,
            ]);
        } catch (\Throwable $th) {
            \Log::error($th);
            return response(['message'=>'Invalid Credentials']);
        }
    }

    public function register(Request $request){
        $registerUserData = $request->validate([
            'name'=>'required|string',
            'email'=>'required|string|email|unique:users',
            'password'=>'required'
        ]);
        $user = User::create([
            'name' => $registerUserData['name'],
            'email' => $registerUserData['email'],
            'password' => Hash::make($registerUserData['password']),
        ]);
        return response()->json([
            'message' => 'User Created ',
        ]);
    }

    public function logout(){
        auth()->user()->tokens()->delete();
    
        return response()->json([
          "message"=>"logged out"
        ]);
    }
}
