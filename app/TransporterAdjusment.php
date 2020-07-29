<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Alfa6661\AutoNumber\AutoNumberTrait;

class TransporterAdjusment extends Model
{
    use AutoNumberTrait;

    protected $primaryKey = 'transporter_adjusment_id';
    protected $guarded = [];
    protected $table = 'transporter_adjusment';

    public function getAutoNumberOptions()
    {
        return [
            'ta_number' => [
                'format' => function () {
                    return 'TA-' . date('Ym') . '-?'; // autonumber format. '?' will be replaced with the generated number.
                },
                'length' => 5 // The number of digits in the autonumber
            ]
        ];
    }

}
