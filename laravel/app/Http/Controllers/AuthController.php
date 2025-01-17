<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    function login(Request $request) {
        $validator = Validator::make($request->all(), [
            'email' => 'required',
            'password' => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $user = User::where('email', $request->email)->first();
    
        if ($user != null && Hash::check($request->password, $user->password)) {
            $token = $user->createToken('authToken')->plainTextToken;
            return response()->json($token);
        }

        return response("Username or password incorrect", 401);
    }

    function register(Request $request) {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => $request->password
        ]);
        $token = $user->createToken('authToken')->plainTextToken;
        return response()->json($token);
    }

    function me(Request $request) {
        $user = User::with('roles')->where('id', Auth::user()->id)->first();
        return response()->json($user);
    }
}
