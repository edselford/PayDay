<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Salary;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class SalaryController extends Controller
{
    public function index()
    {
        $salaries = Salary::all();
        return response()->json($salaries);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'user_id' => 'required|exists:users,id',
            'amount' => 'required|integer',
            'date' => 'required|date',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $salary = Salary::create($request->all());
        return response()->json($salary, 201);
    }

    public function show($id)
    {
        $salary = Salary::find($id);
        if (!$salary) {
            return response()->json(['message' => 'Salary not found'], 404);
        }
        return response()->json($salary);
    }

    public function update(Request $request, $id)
    {
        $salary = Salary::find($id);
        if (!$salary) {
            return response()->json(['message' => 'Salary not found'], 404);
        }

        $validator = Validator::make($request->all(), [
            'amount' => 'sometimes|required|integer',
            'date' => 'sometimes|required|date',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $salary->update($request->all());
        return response()->json($salary);
    }

    public function destroy($id)
    {
        $salary = Salary::find($id);
        if (!$salary) {
            return response()->json(['message' => 'Salary not found'], 404);
        }

        $salary->delete();
        return response()->json(['message' => 'Salary deleted successfully']);
    }
}