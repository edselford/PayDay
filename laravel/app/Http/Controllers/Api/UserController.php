<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\UserResource;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    public function index()
    {
        $users = User::with('role')->latest()->paginate(10);
        return new UserResource(true, 'List Users', $users);
    }


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

        if ($request->has('image')) {
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
        } else {
            $users = User::create([
                'name' => $request->name,
                'age' => $request->age,
                'gender' => $request->gender,
                'born_date' => $request->born_date,
                'role_id' => $request->role_id,
                'email' => $request->email,
                'password' => $request->password
            ]);
        }

        return new UserResource(true, "Success add user", $users);
    }

    public function show($id)
    {
        $user = User::find($id);
        return new UserResource(true, "Detail user", $user);
    }

    public function update(Request $request, $id)
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

        $user = User::find($id);

        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $image->storeAs('public/users', $image->hashName());

            Storage::delete('public/users', basename($user->image));

            $user->update([
                'image' => $image->hashName(),
                'name' => $request->name,
                'age' => $request->age,
                'gender' => $request->gender,
                'born_date' => $request->born_date,
                'role_id' => $request->role_id,
                'email' => $request->email,
                'password' => $request->password
            ]);
        } else {
            $user->update([
                'name' => $request->name,
                'age' => $request->age,
                'gender' => $request->gender,
                'born_date' => $request->born_date,
                'role_id' => $request->role_id,
                'email' => $request->email,
                'password' => $request->password
            ]);
        }

        return new UserResource(true, 'Success update user', $user);
    }

    public function destroy($id)
    {
        $user = User::find($id);

        // deleting
        Storage::delete('public/users', basename($user->image));
        $user->delete();

        return new UserResource(true, "Success delete user", null);
    }
}
