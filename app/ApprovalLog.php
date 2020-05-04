<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ApprovalLog extends Model
{
    /**
     * The primary key for the model.
     * 
     * @var string
     */
    protected $primaryKey = 'approval_log_id';
    protected $guarded = [];
    protected $table = 'approval_log';

}
