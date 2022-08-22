<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\Transporter;
use App\SjpStatus;
use App\PoolPallet;
use App\Sjp;
use DB;

class TransporterController extends Controller
{
    public function index()
    {
        $transporter = Auth::user()->reference_transporter_id;
        $role = Auth::user()->role;
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $user_pool_pallet = PoolPallet::find($pool_pallet);
        $type_pool_pallet = $user_pool_pallet->type;
        if($type_pool_pallet=="POOL_PALLET_DLI" && $role < 5){
        $transporter = DB::table('transporter as a')
            ->join('organization as b', 'a.organization_id', '=', 'b.organization_id')
            ->select('a.*', 'b.organization_name')
            ->where('a.good_pallet', '>', 0 )
            ->orWhere('a.filled_pallet', '>', 0 )
            ->orWhere('a.tbr_pallet', '>', 0 )
            ->orWhere('a.ber_pallet', '>', 0 )
            ->orWhere('a.missing_pallet', '>', 0 )
            ->paginate(10000000)
            ->toArray();
        }
        else{
            $transporter = DB::table('transporter as a')
            ->join('organization as b', 'a.organization_id', '=', 'b.organization_id')
            ->select('a.*', 'b.organization_name')
            ->where('a.transporter_id',$transporter)
            // ->where('a.good_pallet', '>', 0 )
            // ->orWhere('a.tbr_pallet', '>', 0 )
            // ->orWhere('a.ber_pallet', '>', 0 )
            // ->orWhere('a.missing_pallet', '>', 0 )
            ->paginate(1000000)
            ->toArray();
        }

        // $pool = new SjpStatusCollection(PoolPallet::paginate(10));
		 return $transporter;
        // $transporter = new SjpStatusCollection(transporter::paginate(10000000));
		//  return $transporter;
        // return response()->json(Sjp::all()->toArray());
    }

    public function gettransporters()
    {
        $transporter = Auth::user()->reference_transporter_id;
        if($transporter==null){
        $trans = DB::table('transporter as a')
            ->join('organization as b', 'a.organization_id', '=', 'b.organization_id')
            ->select('a.*', 'b.organization_name')
            ->paginate(1000)
            ->toArray();
        }
        else{
            $trans = DB::table('transporter as a')
            ->join('organization as b', 'a.organization_id', '=', 'b.organization_id')
            ->select('a.*', 'b.organization_name')
            ->whereNotIn('a.transporter_id',[$transporter])
            ->paginate(1000)
            ->toArray();
        }

        // $pool = new SjpStatusCollection(PoolPallet::paginate(10));
		 return $trans;
        // return response()->json(Sjp::all()->toArray());
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'transporter_name' => 'required|string',
            'transporter_code' => 'required|string',
            'transporter_address' => 'required|string',
            'transporter_email' => 'required|string',
            'phone_number' => 'required|string',
            'pallet_quota' => 'required|integer',
        ]);

        DB::beginTransaction();
        try{
            $created_by = Auth::user()->name;
            $transporter = Transporter::create([
                'organization_id' => $request->organization_id,
                'transporter_id' => $request->transporter_code,
                'transporter_code' => $request->transporter_code,
                'organization_id' => $request->organization_id,
                'transporter_name' => $request->transporter_name,
                'transporter_address' => $request->transporter_address,
                'phone_number' => $request->phone_number,
                'transporter_email' => $request->transporter_email,
                'pallet_quota' => $request->pallet_quota,
                // 'good_pallet' => $request->good_pallet,
                // 'tbr_pallet' => $request->tbr_pallet,
                // 'ber_pallet' => $request->ber_pallet,
                // 'missing_pallet' => $request->missing_pallet,
                'created_by' => $created_by
            ]);
            DB::commit();
            return response()->json(['status' => 'success'], 200);
        }catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'data' => $e->getMessage(),
                'message' => 'Error Create Transporter'], 422);
        }
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
            // 'transporter_address' => 'required|string',
            'pallet_quota' => 'required'
        ]);

        DB::beginTransaction();
        try{
            $created_by = Auth::user()->name;
            $update = Transporter::find($id);
            $update->transporter_name = $request->transporter_name;
            $update->transporter_code = $request->transporter_code;
            $update->transporter_id = $request->transporter_code;
            $update->organization_id = $request->organization_id;
            $update->pallet_quota = $request->pallet_quota;
            $update->transporter_address = $request->transporter_address;
            $update->transporter_email = $request->transporter_email;
            $update->phone_number = $request->phone_number;
            $update->updated_by = $created_by;
            $update->save();
            DB::commit();
            return response()->json(['status' => 'success'], 200);
        }catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'data' => $e->getMessage(),
                'message' => 'Error Update Transporter Record'], 422);
        }
    }

    public function destroy($id)
    {
        $transporter = Transporter::find($id); //QUERY DATA BERDASARKAN ID
        $transporter->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }

}
