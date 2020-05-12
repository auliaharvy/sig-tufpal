<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Transporter extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'transporter';

    /**
     * The primary key for the model.
     *
     * @var string
     */
    protected $primaryKey = 'transporter_id';

    /**
     * @var array
     */
    protected $fillable = [
        'transporter_id',
        'organization_id',
        'transporter_code',
        'transporter_name',
        'transporter_address',
        'pallet_quota',
        'good_pallet',
        'tbr_pallet',
        'ber_pallet',
        'missing_pallet',
        'phone_number',
        'transporter_email',
        'created_by',
        'updated_by',
        'created_at',
        'updated_at'
    ];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */

}
