<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Alfa6661\AutoNumber\AutoNumberTrait;

class Newpallet extends Model
{
    use AutoNumberTrait;

    protected $primaryKey = 'new_pallet_id';
    protected $guarded = [];
    protected $table = 'new_pallet';

    public function getAutoNumberOptions()
    {
        return [
            'np_number' => [
                'format' => function () {
                    return 'NP-' . date('Ym') . '-?'; // autonumber format. '?' will be replaced with the generated number.
                },
                'length' => 5 // The number of digits in the autonumber
            ]
        ];
    }

}
