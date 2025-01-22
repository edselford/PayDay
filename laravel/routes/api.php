<?php

use App\Http\Controllers\Api\AttendanceController as ApiAttendanceController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\AttendanceController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\EmployeeController;
use App\Http\Controllers\ProfileController;
use App\Http\Resources\UserResource;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Autentikasi
Route::post('/register', [AuthController::class, "register"]);
Route::post('/login', [AuthController::class, "login"]);
Route::get('/me', [AuthController::class, "me"])->middleware('auth:sanctum');

Route::prefix('attendance')
    ->controller(AttendanceController::class)
    ->middleware(['auth:sanctum'])
    ->group(function () {
        Route::post('check', 'check');
        Route::get('status', 'today_status');
    });

Route::post("edit_profile", [ProfileController::class, "edit_profile"])->middleware('auth:sanctum');

// Karyawan
// Route::prefix('employee')
//     ->controller(EmployeeController::class)
//     ->middleware(['auth:sanctum', 'role:manager'])
//     ->group(
//         function () {
//             Route::get('list', 'list');
//             Route::put('change_role/{id}', 'change_role');
//             Route::get('absence_today', 'absence_today');
//         }
//     );

// Users
Route::apiResource('/users', UserController::class);

// Attendance
Route::apiResource('/attendances', ApiAttendanceController::class);
