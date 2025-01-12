<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        User::create([
            'name' => 'Edsel',
            'email' => 'edselmustapa@gmail.com',
            'password' => 'edselmustapa',
            'role' => 'manager'
        ]);

        User::create([
            'name' => 'Izzadin',
            'email' => 'izzadin@gmail.com',
            'password' => 'izzadin123'
        ]);

        User::create([
            'name' => 'Iqbal',
            'email' => 'iqbalhaidee@gmail.com',
            'password' => 'iqbal123'
        ]);

        User::create([
            'name' => 'Arif',
            'email' => 'ryvexc@gmail.com',
            'password' => 'ryve1234'
        ]);
    }
}
