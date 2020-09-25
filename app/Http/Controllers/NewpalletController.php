<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use App\Newpallet;
use App\PoolPallet;
use App\Alltransaction;
use DB;

class NewpalletController extends Controller
{
    public function index()
    {
            $newpallet = DB::table('new_pallet as a')
            ->orderBy('created_at', 'DESC')
            ->join('pool_pallet as b', 'a.pool_pallet_id', '=', 'b.pool_pallet_id')
            ->join('users as c', 'a.adder_user_id', '=', 'c.id')
            ->select('a.*', 'b.pool_name', 'c.name')
            ->paginate(10000000)
            ->toArray();
		 return $newpallet;
    }

    public function show($new_pallet_id)
    {
        $newpallet = Newpallet::find($new_pallet_id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $newpallet]);
    }

    public function edit($id)
    {
        $newpallet = Newpallet::find($id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $newpallet]);
    }

    public function store(Request $request)
    {
        $now = Carbon::now()->toDateTimeString();
        $this->validate($request, [
            'good_pallet' => 'required|integer|gt:-1',
        ]);

        $new_pallet_id = $request->new_pallet_id;
        $pool_pallet_id = auth()->user()->reference_pool_pallet_id;

        DB::beginTransaction();
            try{
                $newpallet = Newpallet::create([
                    'adder_user_id' => auth()->user()->id,
                    'pool_pallet_id' => auth()->user()->reference_pool_pallet_id,
                    'good_pallet' => $request->good_pallet,
                    'vehicle' => $request->vehicle,
                    'driver' => $request->driver,
                    'vendor' => $request->vendor,
                    'note' => $request->note,
                    // 'created_at' => $now,
                    // 'updated_at' => $now,
                ]);

                // Membuat log All Transaction
                    $reporter = Auth::user()->name;
                    $pool_pallet_id = Auth::user()->reference_pool_pallet_id;
                    $transporter_id = Auth::user()->reference_transporter_id;
                    $newpalletreportpool = PoolPallet::find($pool_pallet_id);
                    // $bermissingreporttrans = Transporter::find($transporter_id);
                    $alltransaction = Alltransaction::create([
                        'reference_new_pallet_id' => $newpallet->new_pallet_id,
                        'transaction' => 'New Pallet Report',
                        'sender/reporter' => $reporter,
                        'status' => 'REPORTED',
                        'pool_pallet' => $newpalletreportpool->pool_name,
                        'good_pallet' => $newpallet->good_pallet,
                        'vehicle' => $newpallet->vehicle,
                        'driver' => $newpallet->driver,
                        'note' => $request->note,
                        // 'created_at' => $now,
                        // 'updated_at' => $now,
                    ]);

                $InventoryPool = PoolPallet::find($pool_pallet_id);
                $InventoryPool->good_pallet = (($InventoryPool->good_pallet)+($request->good_pallet));
                $InventoryPool->save();

                DB::commit();
                return response()->json(['status' => 'success',
                                           'data' => $newpallet, ], 200);
            }catch (\Exception $e) {
                DB::rollback();
                return response()->json([
                    'status' => 'error',
                    'data' => $e->getMessage(),
                    'message' => 'Error New Pallet Pallet Record'], 422);
                }
    }

    public function newPalletCancel(Request $request)
    {
        $new_pallet_id = $request->new_pallet_id;
        $pool_pallet_id = auth()->user()->reference_pool_pallet_id;
        $pool_pallet = PoolPallet::find($pool_pallet_id);
        $good_pallet_pool = $pool_pallet->good_pallet;

        $this->validate($request, [
            'good_pallet' => 'required|integer|gt:-1|lte:'.$good_pallet_pool,
        ]);

        $new_pallet_id = $request->new_pallet_id;

        $newPallet = NewPallet::where('new_pallet_id',$new_pallet_id)->first();
        if (empty($new_pallet_id)){
            return response()->json(['error' => 'Data not found'], 404);
        }
        else{
            DB::beginTransaction();
            try{
                $update = NewPallet::find($new_pallet_id);
                if($update->status == 1){
                    return response()->json([
                        'status' => 'error',
                        'data' => 'New Pallet Has Been Cancel',
                        'message' => 'New Pallet Has Been Cancel'], 422);
                }
                $update->good_pallet = $request->good_pallet;
                $update->status = 1;
                $update->note = $request->note;
                $update->updated_by = auth()->user()->name;
                $update->save();

                // Membuat log All Transaction
                    $reporter = Auth::user()->name;
                    $pool_pallet_id = Auth::user()->reference_pool_pallet_id;
                    $transporter_id = Auth::user()->reference_transporter_id;
                    $newpalletreportpool = PoolPallet::find($pool_pallet_id);
                    // $bermissingreporttrans = Transporter::find($transporter_id);
                    $alltransaction = Alltransaction::create([
                        'reference_new_pallet_id' => $update->new_pallet_id,
                        'transaction' => 'New Pallet Cancel',
                        'sender/reporter' => $reporter,
                        'status' => 'CANCELLED',
                        'pool_pallet' => $newpalletreportpool->pool_name,
                        'good_pallet' => $update->good_pallet,
                        'vehicle' => $update->vehicle,
                        'driver' => $update->driver,
                        'note' => $request->note,
                        // 'created_at' => $now,
                        // 'updated_at' => $now,
                    ]);

                $InventoryPool = PoolPallet::find($pool_pallet_id);
                $InventoryPool->good_pallet = (($InventoryPool->good_pallet)-($request->good_pallet));
                $InventoryPool->save();

                DB::commit();
                return response()->json(['status' => 'success',
                                           'data' => $update, ], 200);
            }catch (\Exception $e) {
                DB::rollback();
                return response()->json([
                    'status' => 'error',
                    'data' => $e->getMessage(),
                    'message' => 'Error New Pallet Pallet Cancel'], 422);
                }
        }
    }

    public function destroy($id)
    {
        $newpallet = Newpallet::find($id); //QUERY DATA BERDASARKAN ID
        $newpallet->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }
}
