<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Salary extends Model
{
    use HasFactory;

    protected $table = 'salary';

    protected $fillable = [
        'employee_id',
        'period',
        'basic_salary',
        'allowances',
        'overtime',
        'deductions',
        'total_salary'
    ];

    function employee()
    {
        return $this->belongsTo(Employee::class, 'employee_id');
    }
}
