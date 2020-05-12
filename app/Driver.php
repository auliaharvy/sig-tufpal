<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Driver extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'driver';

    /**
     * The primary key for the model.
     *
     * @var string
     */
    protected $primaryKey = 'driver_id';

    /**
     * @var array
     */
    protected $fillable = [
        'driver_id',
        'transporter_id',
        'driver_name',
        'driver_address',
        'mobile_number',
        'email',
        'created_by',
        'updated_by',
        'created_at',
        'updated_at'
    ];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */

}
