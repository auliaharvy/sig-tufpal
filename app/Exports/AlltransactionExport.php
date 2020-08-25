<?php

namespace App\Exports;

use App\Alltransaction;
use Illuminate\Contracts\View\View;
use Maatwebsite\Excel\Concerns\FromView;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;

class AllTransactionExport implements FromView, ShouldAutoSize
{
    protected $alltransaction;
    public function __construct($alltransaction)
    {
        $this->alltransaction = $alltransaction;
    }

    public function view(): View
    {
        return view('exports.alltransaction', [
            'alltransaction' => $this->alltransaction,
        ]);
    }
}
