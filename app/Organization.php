<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Organization extends Model
{
    /**
     * The table associated with the model.
     * 
     * @var string
     */
    protected $table = 'organization';

    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'organization_id';
    protected $guarded = [];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    
}
