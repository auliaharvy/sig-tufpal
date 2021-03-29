<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Alfa6661\AutoNumber\AutoNumberTrait;

class Filledtogoodpallet extends Model
{
    use AutoNumberTrait;

    protected $primaryKey = 'filled_to_good_id';
    protected $guarded = [];
    protected $table = 'pallet_filled_to_good';

    public function getAutoNumberOptions()
    {
        return [
            'ftg_number' => [
                'format' => function () {
                    return 'FTG-' . date('Ym') . '-?'; // autonumber format. '?' will be replaced with the generated number.
                },
                'length' => 5 // The number of digits in the autonumber
            ]
        ];
    }

}
