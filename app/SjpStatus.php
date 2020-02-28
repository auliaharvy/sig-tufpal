<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Alfa6661\AutoNumber\AutoNumberTrait;

class SjpStatus extends Model
{
    use AutoNumberTrait;

    protected $primaryKey = 'sjp_status_id';
    protected $guarded = [];
    protected $table = 'sjp_status';

    public function getAutoNumberOptions()
    {
        return [
            'sjps_number' => [
                'format' => function () {
                    return 'SJPS-' . date('Ym') . '-?'; // autonumber format. '?' will be replaced with the generated number.
                },
                'length' => 5 // The number of digits in the autonumber
            ]
        ];
    }

}
