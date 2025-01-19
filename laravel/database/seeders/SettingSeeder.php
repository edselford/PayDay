<?php

namespace Database\Seeders;

use App\Models\Setting;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class SettingSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Setting::insert([
            [
                'key_name' => 'jam_masuk',
                'value' => '08:00:00',
                'description' => 'Jam masuk standar kantor',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'key_name' => 'jam_keluar',
                'value' => '17:00:00',
                'description' => 'Jam keluar standar kantor',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'key_name' => 'bonus_lembur_per_jam',
                'value' => '50000',
                'description' => 'Bonus lembur per jam dalam Rupiah',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'key_name' => 'potongan_telat',
                'value' => '100000',
                'description' => 'Potongan keterlambatan dalam Rupiah',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
