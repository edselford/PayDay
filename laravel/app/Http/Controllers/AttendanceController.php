<?php

namespace App\Http\Controllers;

use App\Models\Attendance;
use App\Models\Setting;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AttendanceController extends Controller
{
    /*
    Cara kerja:
    check pertama kali: check-in
    check kedua kali: check-out
    */
    function check() {
        $employee = Auth::user()->employee;
        $today = $employee->todayAttendance();

        if ($today == null) {
            $today = Attendance::create([
                'employee_id' => $employee->id,
                'date' => now(),
                'in' => now(),
                'left' => null,
            ]);
        } else if ($today->left == null) {
            $today->left = now();
            $today->save();
        }

        return $today;
    }

    function today_status() {
        $employee = Auth::user()->employee;
        $today = $employee->todayAttendance();

        if ($today == null) $status = "Not check in yet";
        else if ($today->left == null) $status = "Not check out yet";
        else $status = "Finished Working";

        return [
            "status" => $status,
            "data" => $today,
        ];
    }

}
