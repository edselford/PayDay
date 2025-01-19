<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Employee extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'salary',
        'salary_method',
        'join_date'
    ];

    function attendances()
    {
        return $this->hasMany(Attendance::class, 'employee_id');
    }

    function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    function todayAttendance()
    {
        return $this->attendances()->whereDate('date', now()->toDateString())->first();
    }
}
