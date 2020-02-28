<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use App\Organization;
use App\PoolPallet;
use DB;

class OrganizationController extends Controller
{
    public function index()
    {
        $organization = new SjpStatusCollection(Organization::paginate(10));
		 return $organization;
        // return response()->json(Sjp::all()->toArray());
    }

}
