<?php

namespace App\Http\Controllers;

use App\Http\Resources\SalaryResource;
use App\Models\Employee;
use App\Models\Salary;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class SalaryController extends Controller
{
    public function list(Request $request)
    {
        $users = Salary::with('employee.user')->orderBy('created_at', 'asc')->get();
        $list = [];
        foreach ($users as $item) {
            // $user = User::find($item->employee->user_id)->first();
            $item->period = date('F, Y', strtotime($item->period));
            $list[] = ['data' => $item, 'text' => $item->employee->user->name, 'salary' => $item->total_salary, 'period' => $item->period];
        }
        return response()->json($list);
    }

    function store(Request $request) {
        $validator = Validator::make($request->all(), [
            'employee' => 'required',
            'period' => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $employee = Employee::with('user')->whereHas('user', function ($query) use ($request) {
            $query->where('name', $request->employee);
        })->first();

        $salary = Salary::create([
            'employee_id' => $employee->id,
            'period' => $this->convertToDate($request->period),
            'basic_salary' => floatval($request->salary),
            'allowances' => floatval($request->allowances),
            'overtime' => floatval($request->overtime),
            'deductions' => floatval($request->deductions),
            'total_salary' => floatval($request->total),
        ]);

        return new SalaryResource(true, "Successfully Filled Salary", $salary);
    }

    function convertToDate($input) {
        $months = [
            'Januari' => '01',
            'Februari' => '02',
            'Maret' => '03',
            'April' => '04',
            'Mei' => '05',
            'Juni' => '06',
            'Juli' => '07',
            'Agustus' => '08',
            'September' => '09',
            'Oktober' => '10',
            'November' => '11',
            'Desember' => '12'
        ];

        [$month, $year] = explode(', ', $input);

        $month = trim($month);
        $year = trim($year);

        if (array_key_exists($month, $months)) {
            return "{$year}-{$months[$month]}-01";
        }

        return null;
    }
}
