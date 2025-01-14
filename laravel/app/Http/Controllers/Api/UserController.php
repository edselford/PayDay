<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\UserResource;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    public function index()
    {
        $users = User::with('roles')->latest()->paginate(10);
        return new UserResource(true, 'List Users', $users);
    }


    /**
     * store
     *
     * @param  mixed $request
     * @return void
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'name' => 'required|string|max:255',
            'age' => 'required|integer|min:0',
            'gender' => 'required|in:m,f',
            'born_date' => 'required|date',
            'role_id' => 'required|exists:roles,id',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|string|min:8'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        //upload image
        $image = $request->file('image');
        $image->storeAs('public/users', $image->hashName());

        $users = User::create([
            'image' => $image->hashName(),
            'name' => $request->name,
            'age' => $request->age,
            'gender' => $request->gender,
            'born_date' => $request->born_date,
            'role_id' => $request->role_id,
            'email' => $request->email,
            'password' => $request->password
        ]);

        return new UserResource(true, "Success add user", $users);
    }
}
