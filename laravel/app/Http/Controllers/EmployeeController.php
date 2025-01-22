<?php

namespace App\Http\Controllers;

use App\Models\Absence;
use App\Models\Employee;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class EmployeeController extends Controller
{
    public function list(Request $request)
    {
        $users = Employee::with('user')->get();
        $list = [];
        foreach ($users as $item) {
            $list[] = ['text' => $item->user->name, 'salary' => $item->salary];
        }
        return response()->json($list);
    }

    // public function absence_today(Request $request)
    // {
    //     $absence = Absence::whereDate('date', Carbon::today())->get();
    //     return response()->json($absence);
    // }

    // public function change_role(Request $request, int $id)
    // {
    //     $validator = Validator::make($request->all(), [
    //         'role' => 'required|in:user,manager'
    //     ]);
    //     if ($validator->fails()) return response()->json($validator->errors(), 422);

    //     $user = User::where('id', $id)->first();
    //     if ($user == null) return response("User Not Found", 404);
    //     if ($user->id == Auth::user()->id) return response("Can't change your own role", 400);

    //     $user->role = $request->role;
    //     $user->save();

    //     return response()->json($user);
    // }
}
