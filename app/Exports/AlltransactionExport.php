<?php

namespace App\Exports;

use App\Alltransaction;
use Illuminate\Contracts\View\View;
use Maatwebsite\Excel\Concerns\FromView;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;

class TransactionExport implements FromView, ShouldAutoSize
{
    protected $alltransaction;
    protected $month;
    protected $year;
    public function __construct($transaction, $month, $year)
    {
        $this->alltransaction = $alltransaction;
        $this->month = $month;
        $this->year = $year;
    }

    public function view(): View
    {
        return view('exports.transaction', [
            'transaction' => $this->alltransaction,
            'month' => $this->month,
            'year' => $this->year
        ]);
    }
}
