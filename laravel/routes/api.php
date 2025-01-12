<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\EmployeeController;
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

// Karyawan
Route::prefix('employee')
    ->controller(EmployeeController::class)
    ->middleware(['auth:sanctum', 'role:manager'])
    ->group(function() {
        Route::get('list', 'list');
        Route::put('change_role/{id}', 'change_role');
        Route::get('absence_today', 'absence_today');
    }
);