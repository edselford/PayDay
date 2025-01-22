<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class ProfileController extends Controller
{
    function edit_profile(Request $request) {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'gender' => 'required|in:m,f',
            'born_date' => 'required|date',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $user = User::find(Auth::id());
        $user->name = $request->name;
        $user->gender = $request->gender;
        $user->born_date = $request->born_date;
        $user->save();

        return response()->json($user);
    }
}
