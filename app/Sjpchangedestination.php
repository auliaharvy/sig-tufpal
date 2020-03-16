<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Alfa6661\AutoNumber\AutoNumberTrait;

class Sjpchangedestination extends Model
{
    use AutoNumberTrait;

    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'sjp_change_destination_id';
    protected $guarded = [];
    protected $table = 'sjp_change_destination';

    public function getAutoNumberOptions()
    {
        return [
            'scd_number' => [
                'format' => function () {
                    return 'SCD-' . date('Ym') . '-?'; // autonumber format. '?' will be replaced with the generated number.
                },
                'length' => 5 // The number of digits in the autonumber
            ]
        ];
    }
}
