<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\PalletTransferCollection;
use Illuminate\Support\Facades\Auth;
use App\PalletTransfer;
use App\PoolPallet;
use App\Transporter;
use DB;

class PalletTransferController extends Controller
{
    public function index()
    {
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $role = Auth::user()->role;
        if($pool_pallet==1 && $role<7){
        $pallettransfer = DB::table('pallet_transfer as a')
            ->join('pool_pallet as b', 'a.departure_pool_pallet_id', '=', 'b.pool_pallet_id')
            ->join('pool_pallet as c', 'a.destination_pool_pallet_id', '=', 'c.pool_pallet_id')
            ->join('users as d', 'a.sender_user_id', '=', 'd.id')
            ->join('users as e', 'a.receiver_user_id', '=', 'e.id')
            ->join('transporter as f', 'a.transporter_id', '=', 'f.transporter_id')
            ->join('vehicle as g', 'a.vehicle_id', '=', 'g.vehicle_id')
            ->join('driver as h', 'a.driver_id', '=', 'h.driver_id')
            ->select('a.*', 'b.pool_name as dep_pool', 'c.pool_name as dest_pool',
                    'd.name as sender_name','e.name as receiver_name', 'f.transporter_name',
                    'g.vehicle_number', 'h.driver_name', 'b.pool_pallet_id as departure', 'c.pool_pallet_id as destination')
            ->paginate(10000000)
            ->toArray();
        }
        else{
            $pallettransfer = DB::table('pallet_transfer as a')
            ->join('pool_pallet as b', 'a.departure_pool_pallet_id', '=', 'b.pool_pallet_id')
            ->join('pool_pallet as c', 'a.destination_pool_pallet_id', '=', 'c.pool_pallet_id')
            ->join('users as d', 'a.sender_user_id', '=', 'd.id')
            ->join('users as e', 'a.receiver_user_id', '=', 'e.id')
            ->join('transporter as f', 'a.transporter_id', '=', 'f.transporter_id')
            ->join('vehicle as g', 'a.vehicle_id', '=', 'g.vehicle_id')
            ->join('driver as h', 'a.driver_id', '=', 'h.driver_id')
            ->select('a.*', 'b.pool_name as dep_pool', 'c.pool_name as dest_pool',
                    'd.name as sender_name','e.name as receiver_name', 'f.transporter_name',
                    'g.vehicle_number', 'h.driver_name', 'b.pool_pallet_id as departure', 'c.pool_pallet_id as destination')
            ->where('b.pool_pallet_id',$pool_pallet)
            ->orWhere('c.pool_pallet_id',$pool_pallet)
            ->paginate(1000000)
            ->toArray();
        }
        // // $sjp = new SjpCollection($sjp1);
        return $pallettransfer;
        // $sjpstatus = new SjpStatusCollection(SjpStatus::paginate(10));
		//  return $sjpstatus;
        // return response()->json(Sjp::all()->toArray());
    }

    public function show($pallet_transfer_id)
    {
        $pallettransfer = PalletTransfer::find($pallet_transfer_id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $pallettransfer]);
    }
    

    public function store(Request $request)
    {
        $pallet_transfer_id = $request->pallet_transfer_id;
        $transporter_id = $request->transporter_id;
        $departure_id = Auth::user()->reference_pool_pallet_id;
        $destination_id = $request->destination_pool_pallet_id;

        $this->validate($request, [
            'good_pallet' => 'required|integer|gt:-1',
            'tbr_pallet' => 'required|integer|gt:-1',
            'reason' => 'required',
        ]);

        $InventoryDept = PoolPallet::find($departure_id);
        $good_pallet = $InventoryDept->good_pallet;
        $tbr_pallet  = $InventoryDept->tbr_pallet;
        if($good_pallet<$request->good_pallet || $tbr_pallet < $request->$tbr_pallet){
            return response()->json(['error' => 'Qty Pallet melebihi pallet yang ada'], 404);
        }    
        else{
            $checker = Auth::user()->id;
            $palletTransfer = PalletTransfer::create([
                'departure_pool_pallet_id' => Auth::user()->reference_pool_pallet_id,
                'destination_pool_pallet_id' => $request->destination_pool_pallet_id,
                'sender_user_id' => $checker, 
                'receiver_user_id' => 5,
                'vehicle_id' => $request->vehicle_id, 
                'driver_id' => $request->driver_id, 
                'transporter_id' => $request->transporter_id, 
                'good_pallet' => $request->good_pallet, 
                'tbr_pallet' => $request->tbr_pallet, 
                'reason' => $request->reason, 
                'note' => $request->note, 
                'status' => 0,
            ]);

            $InventoryDept = PoolPallet::find($departure_id);
            $InventoryDept->good_pallet = (($InventoryDept->good_pallet)-($request->good_pallet));
            $InventoryDept->tbr_pallet = (($InventoryDept->tbr_pallet)-($request->tbr_pallet));
            $InventoryDept->save();

            $InventoryTrans = Transporter::find($transporter_id);
            $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)+($request->good_pallet));
            $InventoryTrans->tbr_pallet = (($InventoryTrans->tbr_pallet)+($request->tbr_pallet));
            $InventoryTrans->save();

            $data = [
                'data' => $palletTransfer,
                'status' => (bool) $palletTransfer,
                'message' => $palletTransfer ? 'Pallet Transfer Record Created!' : 'Error Creating Pallet Transfer Record' 
            ];
        }
        return response()->json($data);
    }

    public function receive(Request $request)
    {
        $pallet_transfer_id = $request->pallet_transfer_id;
        $transporter_id = $request->transporter_id;
        // $departure_id = $request->departure_pool_pallet_id;
        $destination_id = $request->destination_pool_pallet_id;

        $this->validate($request, [
            'good_pallet' => 'required|integer|gt:-1',
            'tbr_pallet' => 'required|integer|gt:-1',
        ]);

        $palletTransfer = PalletTransfer::where('pallet_transfer_id',$pallet_transfer_id)->first();
        if (empty($palletTransfer)){
            return response()->json(['error' => 'Data not found'], 404);
        }
        else{
            $InventoryTrans = Transporter::find($transporter_id);
            $good_pallet = $InventoryTrans->good_pallet;
            $tbr_pallet  = $InventoryTrans->tbr_pallet;
            if($good_pallet<$request->good_pallet || $tbr_pallet<$request->tbr_pallet){
                return response()->json(['error' => 'Qty Pallet melebihi pallet yang ada'], 404);
            }    
            $checker = Auth::user()->id;
            $update = PalletTransfer::find($pallet_transfer_id);
            // $update->departure_pool_pallet_id = $request->departure_pool_pallet_id;
            $update->destination_pool_pallet_id = $request->destination_pool_pallet_id;
            $update->sender_user_id = $request->sender_user_id;
            $update->receiver_user_id = $checker;
            $update->vehicle_id = $request->vehicle_id;
            $update->driver_id = $request->driver_id;
            $update->transporter_id = $request->transporter_id; 
            $update->good_pallet = $request->good_pallet;
            $update->tbr_pallet = $request->tbr_pallet;
            $update->reason = $request->reason;
            $update->note = $request->note;
            $update->status = 1;
            $update->save();

            $InventoryDest = PoolPallet::find($destination_id);
            $InventoryDest->good_pallet = (($InventoryDest->good_pallet)+($request->good_pallet));
            $InventoryDest->tbr_pallet = (($InventoryDest->tbr_pallet)+($request->tbr_pallet));
            $InventoryDest->save();
            
            $InventoryTrans = Transporter::find($transporter_id);
            $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)-($request->good_pallet));
            $InventoryTrans->tbr_pallet = (($InventoryTrans->tbr_pallet)-($request->tbr_pallet));
            $InventoryTrans->save();

        }

       

        $data = [
            'data' => $update,
            'status' => (bool) $update,
            'message' => $update ? 'Pallet Transfer Record Updated!' : 'Error Updating Pallet Transfer Record' 
        ];

        return response()->json($data);
    }

    public function destroy($id)
    {
        $pallettransfer = PalletTransfer::find($id); //QUERY DATA BERDASARKAN ID
        $pallettransfer->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }

}
