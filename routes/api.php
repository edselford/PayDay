<?php

use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\AuthController;
//use App\Http\Controllers\EmployeeController;
use App\Http\Resources\UserResource;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\EmployeeController;
use App\Http\Controllers\Api\SalaryController;
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


Route::middleware(['auth:sanctum'])->group(function () {
    Route::apiResource('employees', EmployeeController::class);
    Route::apiResource('salaries', SalaryController::class);
});