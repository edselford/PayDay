<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\AttendanceResource;
use App\Models\Attendance;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class AttendanceController extends Controller
{
    public function index()
    {
        $attendance = Attendance::with('employees')->latest()->paginate(10);
        return new AttendanceResource(true, "Attendance List", $attendance);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            "employee_id" => "required|exists:employees,id",
            "date" => "required|date",
            "in" => "required|date_format:H:i:s",
            "left" => "nullable|date_format:H:i:s"
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        if ($request->has('left')) {
            $attendance = Attendance::create([
                "employee_id" => $request->employee_id,
                "date" => $request->date,
                "in" => $request->in,
                "left" => $request->left
            ]);
        } else {
            $attendance = Attendance::create([
                "employee_id" => $request->employee_id,
                "date" => $request->date,
                "in" => $request->in
            ]);
        }

        return new AttendanceResource(true, "Successfully Filled Attendance", $attendance);
    }

    public function show($id)
    {
        $attendance = Attendance::find($id);
        return new AttendanceResource(true, "Attendance List From", $attendance);
    }

    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            "employee_id" => "required|exists:employees,id",
            "date" => "required|date",
            "in" => "required|date_format:H:i:s",
            "left" => "nullable|date_format:H:i:s"
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $attendance = Attendance::find($id);

        if ($request->has('left')) {
            $attendance->update([
                "employee_id" => $request->employee_id,
                "date" => $request->date,
                "in" => $request->in,
                "left" => $request->left
            ]);
        } else {
            $attendance->update([
                "employee_id" => $request->employee_id,
                "date" => $request->date,
                "in" => $request->in
            ]);
        }


        return new AttendanceResource(true, "Successfully Updated Attendance", $attendance);
    }

    public function destroy($id)
    {
        $attendance = Attendance::find($id);
        $attendance->delete();

        return new AttendanceResource(true, "Successfully Deleted Attendance", null);
    }
}
