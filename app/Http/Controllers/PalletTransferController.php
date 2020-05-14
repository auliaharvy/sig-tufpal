<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\PalletTransferCollection;
use Illuminate\Support\Facades\Auth;
use App\DeletedItem;
use App\PalletTransfer;
use App\Pallettransfersend;
use App\Pallettransferreceive;
use App\PoolPallet;
use App\Vehicle;
use App\Driver;
use App\Transporter;
use App\Alltransaction;
use DB;

class PalletTransferController extends Controller
{
    public function index()
    {
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $transporter = Auth::user()->reference_transporter_id;
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
            ->where('a.status',0)
            ->paginate(10000000)
            ->toArray();
        }
        else{
            $pallettransfer = DB::table(DB::raw('(SELECT * FROM pallet_transfer WHERE status = 0)a'))
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
            ->orWhere('a.transporter_id',$transporter)
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
        $pallet_transfer = DB::table('pallet_transfer')->where('pallet_transfer_id',$pallet_transfer_id)->first();
        $transporter_id = $request->transporter_id;
        $driver_id = $request->driver_id;
        $vehicle_id = $request->vehicle_id;
        $departure_id = Auth::user()->reference_pool_pallet_id;
        $destination_id = $request->destination_pool_pallet_id;
        $InventoryDept = PoolPallet::find($departure_id);
        $good_pallet = $InventoryDept->good_pallet;
        $tbr_pallet  = $InventoryDept->tbr_pallet;

        $this->validate($request, [
            'good_pallet' => 'required|integer|gt:-1|lte:'.$good_pallet,
            'tbr_pallet' => 'required|integer|gt:-1|lte:'.$tbr_pallet,
            'reason' => 'required',
        ]);

        DB::beginTransaction();
        try{
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

            // Membuat log transaksi send pallet transfer
            $sender = Auth::user()->name;
            $palletsenddept = PoolPallet::find($departure_id);
            $palletsenddest = PoolPallet::find($destination_id);
            $palletsendtrans = Transporter::find($transporter_id);
            $palletsenddriver = Driver::find($driver_id);
            $palletsendvehicle = Vehicle::find($vehicle_id);
            $Pallettransfersend = Pallettransfersend::create([
                'pallet_transfer_id' => $palletTransfer->pallet_transfer_id,
                'sender' => $sender,
                'pallet_transfer_status' => 'SEND',
                'departure_pool' => $palletsenddept->pool_name,
                'destination_pool' => $palletsenddest->pool_name,
                'transporter' => $palletsendtrans->transporter_name,
                'driver' => $palletsenddriver->driver_name,
                'vehicle' => $palletsendvehicle->vehicle_number,
                'good_pallet' => $request->good_pallet,
                'tbr_pallet' => $request->tbr_pallet,
                'note' => $request->note,
            ]);

            // Membuat log All Transaction
            $sender = Auth::user()->name;
            $palletsenddept = PoolPallet::find($departure_id);
            $palletsenddest = PoolPallet::find($destination_id);
            $palletsendtrans = Transporter::find($transporter_id);
            $palletsenddriver = Driver::find($driver_id);
            $palletsendvehicle = Vehicle::find($vehicle_id);
            $alltransaction = Alltransaction::create([
                'reference_pallet_transfer_id' => $palletTransfer->pallet_transfer_id,
                'transaction' => 'Transfer Pallet Send',
                'sender/reporter' => $sender,
                'status' => 'SEND',
                'departure_pool' => $palletsenddept->pool_name,
                'destination_pool' => $palletsenddest->pool_name,
                'transporter' => $palletsendtrans->transporter_name,
                'driver' => $palletsenddriver->driver_name,
                'vehicle' => $palletsendvehicle->vehicle_number,
                'good_pallet' => $palletTransfer->good_pallet,
                'tbr_pallet' => $palletTransfer->tbr_pallet,
                'reason' => $palletTransfer->reason,
                'note' => $request->note,
            ]);

            $InventoryDept = PoolPallet::find($departure_id);
            $InventoryDept->good_pallet = (($InventoryDept->good_pallet)-($request->good_pallet));
            $InventoryDept->tbr_pallet = (($InventoryDept->tbr_pallet)-($request->tbr_pallet));
            $InventoryDept->save();

            $InventoryTrans = Transporter::find($transporter_id);
            $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)+($request->good_pallet));
            $InventoryTrans->tbr_pallet = (($InventoryTrans->tbr_pallet)+($request->tbr_pallet));
            $InventoryTrans->save();

            DB::commit();
            return response()->json(['status' => 'success'], 200);
        }catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'data' => $e->getMessage(),
                'message' => 'Error Transfer Pallet Record'], 422);
            }
    }

    public function receive(Request $request)
    {
        $pallet_transfer_id = $request->pallet_transfer_id;
        $transporter_id = $request->transporter_id;
        $departure_id = $request->departure_pool_pallet_id;
        $destination_id = $request->destination_pool_pallet_id;
        $InventoryTrans = Transporter::find($transporter_id);
        $update = PalletTransfer::find($pallet_transfer_id);
        $good_pallet = $update->good_pallet;
        $tbr_pallet = $update->tbr_pallet;
        $good_pallet = $InventoryTrans->good_pallet;
        $tbr_pallet  = $InventoryTrans->tbr_pallet;
        $total = $good_pallet+$tbr_pallet;

        $this->validate($request, [
            'good_pallet' => 'required|integer|gt:-1|lte:'.$total,
            'tbr_pallet' => 'required|integer|gt:-1|lte:'.$total,
        ]);

        $palletTransfer = PalletTransfer::where('pallet_transfer_id',$pallet_transfer_id)->first();
        if (empty($palletTransfer)){
            return response()->json(['error' => 'Data not found'], 404);
        }
        else{
            // $InventoryTrans = Transporter::find($transporter_id);
            // $good_pallet = $InventoryTrans->good_pallet;
            // $tbr_pallet  = $InventoryTrans->tbr_pallet;
            // if($good_pallet<$request->good_pallet || $tbr_pallet<$request->tbr_pallet){
            //     return response()->json(['error' => 'Qty Pallet melebihi pallet yang ada'], 404);
            // }
            $good_pallet_awal = $update->good_pallet; //ambil qty good pallet awal
            $tbr_pallet_awal = $update->tbr_pallet; //ambil qty tbr pallet awal
            $good_palletrcv = $request->good_pallet;
            $tbr_palletrcv = $request->tbr_pallet;

            if($tbr_palletrcv>($total-$good_palletrcv)){
                return response()->json(['error' => 'Qty Receive melebihi data yang di send'], 404);
            }
            else{
                DB::beginTransaction();
                try{
                    $checker = Auth::user()->id;
                    $update = PalletTransfer::find($pallet_transfer_id);
                    // $update->departure_pool_pallet_id = $request->departure_pool_pallet_id;
                    // $update->destination_pool_pallet_id = $request->destination_pool_pallet_id;
                    // $update->sender_user_id = $request->sender_user_id;

                    $update->receiver_user_id = $checker;
                    // $update->vehicle_id = $request->vehicle_id;
                    // $update->driver_id = $request->driver_id;
                    // $update->transporter_id = $request->transporter_id;
                    $update->good_pallet = $good_palletrcv;
                    $update->tbr_pallet = $tbr_palletrcv;
                    // $update->reason = $request->reason;
                    $update->note = $request->note;
                    $update->status = 1;
                    $update->save();

                    $InventoryDest = PoolPallet::find($destination_id);
                    $InventoryDest->good_pallet = (($InventoryDest->good_pallet)+($good_palletrcv)); //hanya receive good pallet
                    $InventoryDest->tbr_pallet = (($InventoryDest->tbr_pallet)+($tbr_palletrcv));
                    // $InventoryDest->ber_pallet = (($InventoryDest->ber_pallet)+($request->ber_pallet)); // ber & missing dicatat di transporter
                    // $InventoryDest->missing_pallet = (($InventoryDest->missing_pallet)+($request->missing_pallet)); // ber & missing dicatat di transporter
                    $InventoryDest->save();

                    $InventoryTrans = Transporter::find($transporter_id);
                        if($tbr_pallet_awal==0){ //jika saat send tidak terdapat tbr pallet
                            $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)-($good_pallet_awal));

                        }
                        else if(($request->tbr_pallet)>$tbr_pallet_awal){ //jika rcv tbr pallet lebih besar dari yang di send
                            $selisihtbr = ($request->tbr_pallet)-$tbr_pallet_awal;
                            $selisihgood = $good_pallet_awal-($request->good_pallet);
                            if($selisihgood==$selisihtbr){
                                $InventoryTrans->tbr_pallet = (($InventoryTrans->tbr_pallet)-($tbr_pallet_awal));
                                $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)-($good_pallet_awal));
                            }

                        }
                        else{
                            $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)-($request->good_pallet));
                            $InventoryTrans->tbr_pallet = (($InventoryTrans->tbr_pallet)-($request->tbr_pallet));
                        }
                        $InventoryTrans->save();

                    $transporter_id = $update->transporter_id;
                    $driver_id = $update->driver_id;
                    $vehicle_id = $update->vehicle_id;
                    $tp_number = $update->tp_number;
                    $departure_id = $update->departure_pool_pallet_id;
                    $destination_id = $update->destination_pool_pallet_id;
                    $transporter_id = $update->transporter_id;
                    $driver_id = $update->driver_id;
                    $vehicle_id = $update->vehicle_id;

                    // Membuat log transaksi receive pallet transfer
                    $receiver = Auth::user()->name;
                    $palletsenddept = PoolPallet::find($departure_id);
                    $palletsenddest = PoolPallet::find($destination_id);
                    $palletsendtrans = Transporter::find($transporter_id);
                    $palletsenddriver = Driver::find($driver_id);
                    $palletsendvehicle = Vehicle::find($vehicle_id);
                    $Pallettransferreceive = Pallettransferreceive::create([
                        'receiver' => $receiver,
                        'tp_number' => $tp_number,
                        'pallet_transfer_status' => 'RECEIVE',
                        'departure_pool' => $palletsenddept->pool_name,
                        'destination_pool' => $palletsenddest->pool_name,
                        'transporter' => $palletsendtrans->transporter_name,
                        'driver' => $palletsenddriver->driver_name,
                        'vehicle' => $palletsendvehicle->vehicle_number,
                        'good_pallet' => $request->good_pallet,
                        'tbr_pallet' => $request->tbr_pallet,
                        'note' => $request->note,
                    ]);

                    // Membuat log All Transaction
                    $receiver = Auth::user()->name;
                    $palletsenddept = PoolPallet::find($departure_id);
                    $palletsenddest = PoolPallet::find($destination_id);
                    $palletsendtrans = Transporter::find($transporter_id);
                    $palletsenddriver = Driver::find($driver_id);
                    $palletsendvehicle = Vehicle::find($vehicle_id);
                    $alltransaction = Alltransaction::create([
                        'reference_pallet_transfer_id' => $palletTransfer->pallet_transfer_id,
                        'transaction' => 'Transfer Pallet Receive',
                        'receiver/approver' => $receiver,
                        'status' => 'RECEIVE',
                        'departure_pool' => $palletsenddept->pool_name,
                        'destination_pool' => $palletsenddest->pool_name,
                        'transporter' => $palletsendtrans->transporter_name,
                        'driver' => $palletsenddriver->driver_name,
                        'vehicle' => $palletsendvehicle->vehicle_number,
                        'good_pallet' => $palletTransfer->good_pallet,
                        'tbr_pallet' => $palletTransfer->tbr_pallet,
                        'reason' => $palletTransfer->reason,
                        'note' => $request->note,
                    ]);

                    DB::commit();
                    return response()->json(['status' => 'success'], 200);
                }catch (\Exception $e) {
                    DB::rollback();
                    return response()->json([
                        'status' => 'error',
                        'data' => $e->getMessage(),
                        'message' => 'Error Transfer Pallet Record'], 422);
                }
            }
        }
    }

    public function destroy($id)
    {
        $pallettransfer = PalletTransfer::find($id);
        $sender_user= User::find($pallettransfer->sender_user_id);
        $receiver_user = User::find($pallettransfer->receiver_user_id);
        $departure_pool_pallet = PoolPallet::find($pallettransfer->departure_pool_pallet_id);
        $destination_pool_pallet = PoolPallet::find($pallettransfer->destination_pool_pallet_id);
        $transporter = Transporter::find($pallettransfer->transporter_id);
        $driver = Driver::find($pallettransfer->driver_id);
        $vehicle = Vehicle::find($pallettransfer->vehicle_id);
        DB::beginTransaction();
        try{
                $deleted_item = DeletedItem::create([
                    'tp_number' => $pallettransfer->tp_number,
                    // 'sjps_number' => $sjp_status->sjps_number,
                    'pool_pallet' => $pool_pallet->pool_name,
                    // 'transporter' => $transporter->transporter_name,
                    'reporter/sender' => $sender_user->name,
                    // 'receiver/approver' => $receiver_user->name,
                    'departure_pool' => $departure_pool_pallet->pool_name,
                    'destination_pool' => $destination_pool_pallet->pool_name,
                    'transporter' => $transporter->transporter_name,
                    'driver' => $driver->driver_name,
                    'vehicle' => $vehicle->vehicle_number,
                    'good_pallet' => $pallettransfer->good_pallet,
                    'tbr_pallet' => $pallettransfer->tbr_pallet,
                    'created_by' => auth()->user()->name,
                    'note' => $pallettransfer->note,
                ]);
            $pallettransfer->delete(); //KEMUDIAN HAPUS DATA TERSEBUT

        DB::commit();
        return response()->json(['status' => 'success'], 200);

        }catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'data' => $e->getMessage(),
                'message' => 'Error Delete Transfer Pallet Record'], 422);
        }
    }

}
