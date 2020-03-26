<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Alfa6661\AutoNumber\AutoNumberTrait;

class Alltransaction extends Model
{
    use AutoNumberTrait;

    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'all_transaction_id';
    protected $guarded = [];
    protected $table = 'all_transaction';

    public function getAutoNumberOptions()
    {
        return [
            'tid_number' => [
                'format' => function () {
                    return 'TID-' . date('Ym') . '-?'; // autonumber format. '?' will be replaced with the generated number.
                },
                'length' => 5 // The number of digits in the autonumber
            ]
        ];
    }
}
