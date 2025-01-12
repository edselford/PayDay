<?php

namespace Database\Seeders;

use App\Models\Absence;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class AbsenceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $user = User::where('email', 'izzadin@gmail.com')->first();
        Absence::create([
            'user_id' => $user->id,
            'date' => Carbon::now(),
            'is_absence' => true
        ]);

        $user = User::where('email', 'ryvexc@gmail.com')->first();
        Absence::create([
            'user_id' => $user->id,
            'date' => Carbon::now(),
            'is_absence' => true
        ]);
    }
}
