<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class PoolPallet extends Model
{
    /**
     * The table associated with the model.
     * 
     * @var string
     */
    protected $table = 'pool_pallet';

    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'pool_pallet_id';

    /**
     * @var array
     */
    protected $fillable = ['organization_id', 'code', 'type', 'pool_name', 'pool_address', 'pool_city', 'phone_number', 'pool_email', 'pallet_quota', 'good_pallet', 'tbr_pallet', 'ber_pallet', 'missing_pallet', 'created_at', 'updated_at'];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    
}
