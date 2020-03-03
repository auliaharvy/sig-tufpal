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
        $transporter = new SjpStatusCollection(transporter::paginate(10000000));
		 return $transporter;
        // return response()->json(Sjp::all()->toArray());
    }

    public function store(Request $request)
    {
        $transporter = Transporter::create([
            'organization_id' => $request->organization_id,  
            'transporter_name' => $request->transporter_name, 
            'transporter_address' => $request->transporter_address, 
            'phone_number' => $request->phone_number, 
            'transporter_email' => $request->transporter_email, 
            'pallet_quota' => $request->pallet_quota,
            'good_pallet' => $request->good_pallet, 
            'tbr_pallet' => $request->tbr_pallet, 
            'ber_pallet' => $request->ber_pallet, 
            'missing_pallet' => $request->missing_pallet, 
        ]);

        $data = [
            'data' => $transporter,
            'status' => (bool) $transporter,
            'message' => $transporter ? 'Transporter Created!' : 'Error Creating Transporter' 
        ];

        return response()->json($data);
    }

    public function edit($id)
    {
        $transporter = Transporter::find($id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $transporter]);
    }

    public function update(Request $request, $id)
    {
        //VALIDASI DATA YANG DITERIMA
        $this->validate($request, [
            'transporter_name' => 'required|string',
            'transporter_address' => 'required|string',
            'pallet_quota' => 'required'
        ]);

        $transporter = Transporter::find($id); //QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        $transporter->update($request->all()); //UPDATE DATA BERDASARKAN DATA YANG DITERIMA
        return response()->json(['status' => 'success']);
    }

    public function destroy($id)
    {
        $transporter = Transporter::find($id); //QUERY DATA BERDASARKAN ID
        $transporter->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }

}
