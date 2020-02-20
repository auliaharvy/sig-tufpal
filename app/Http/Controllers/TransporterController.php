<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use App\Transporter;
use App\SjpStatus;
use App\Sjp;
use DB;

class TransporterController extends Controller
{
    public function index()
    {
        $transporter = new SjpStatusCollection(transporter::paginate(10));
		 return $transporter;
        // return response()->json(Sjp::all()->toArray());
    }

    

}
