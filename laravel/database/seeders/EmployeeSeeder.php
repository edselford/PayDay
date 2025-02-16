<?php

namespace Database\Seeders;

use App\Models\Employee;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class EmployeeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // $users = User::where('role_id', '!=', 1)->get();
        $users = User::all();

        foreach ($users as $user) {
            Employee::create([
                'user_id' => $user->id,
                'salary_method' => 'perbulan',
                'salary' => 5000000.0,
                'join_date' => now()
            ]);
        }
    }
}
