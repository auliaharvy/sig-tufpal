<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\Damagedpallet;
use App\PoolPallet;
use DB;

class DamagedpalletController extends Controller
{
    public function index()
    {
        //     $damagedpallet = DB::table('damaged_pallet as a')
        //     ->join('pool_pallet as b', 'a.pool_pallet_id', '=', 'b.pool_pallet_id')
        //     ->join('users as c', 'a.reporter_user_id', '=', 'c.id')
        //     ->select('a.*', 'b.pool_name', 'c.name')
        //     ->paginate(10000000)
        //     ->toArray();
        //  return $damagedpallet;
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $transporter = Auth::user()->reference_transporter_id;
        $role = Auth::user()->role;
        if($pool_pallet==1 && $role<7){
            $damagedpallet = DB::table('damaged_pallet as a')
            ->join('users as b', 'a.reporter_user_id', '=', 'b.id')
            ->leftJoin('pool_pallet as c', 'a.pool_pallet_id', '=', 'c.pool_pallet_id')
            ->leftJoin('transporter as d', 'a.transporter_id', '=', 'd.transporter_id')
            ->leftJoin('sjp_status as e', 'a.reference_sjp_status_id', '=', 'e.sjp_status_id')
            ->select('a.*', 'b.name',
                    'c.pool_name','d.transporter_name', 'e.sjps_number')
           
            ->paginate(10000000)
            ->toArray();
        }
        else{
            $damagedpallet = DB::table('damaged_pallet as a')
            ->join('users as b', 'a.reporter_user_id', '=', 'b.id')
            ->leftJoin('pool_pallet as c', 'a.pool_pallet_id', '=', 'c.pool_pallet_id')
            ->leftJoin('transporter as d', 'a.transporter_id', '=', 'd.transporter_id')
            ->leftJoin('sjp_status as e', 'a.reference_sjp_status_id', '=', 'e.sjp_status_id')
            ->select('a.*', 'b.name',
                    'c.pool_name','d.transporter_name', 'e.sjps_number')
            ->where('a.pool_pallet_id',$pool_pallet)
            ->orWhere('a.transporter_id', $transporter)
            ->paginate(10000000)
            ->toArray();
        }
        
       
        return $damagedpallet;
        // return response()->json(Sjp::all()->toArray());
    }

    public function show($damaged_pallet_id)
    {
        $damagedpallet = Damagedpallet::find($damaged_pallet_id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $damagedpallet]);
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'tbr_pallet' => 'required|gt:0',
        ]);

        $damaged_pallet_id = $request->damaged_pallet_id;
        $pool_pallet_id = auth()->user()->reference_pool_pallet_id;
        $transporter_id = auth()->user()->reference_transporter_id;
        $pallet = PoolPallet::find($pool_pallet_id); //jgn lupa add model poolpallet
        $qty_pool = $pallet->good_pallet;
        $pallet_qty = $request->tbr_pallet;


        if($pallet_qty>$qty_pool)
        {
            return response()->json(['error' => 'Pallet Melebihi Quantity yang ada'], 404);
        }
        else {
            $damagedpallet = Damagedpallet::create([
                'reporter_user_id' => auth()->user()->id,
                'pool_pallet_id' => auth()->user()->reference_pool_pallet_id, 
                'transporter_id' => auth()->user()->reference_transporter_id, 
                'tbr_pallet' => $request->tbr_pallet, 
                'note' => $request->note, 
            ]);
            if($pool_pallet_id!=null){
                $InventoryPool = PoolPallet::find($pool_pallet_id);
                $InventoryPool->good_pallet = (($InventoryPool->good_pallet)-($request->tbr_pallet));
                $InventoryPool->tbr_pallet = (($InventoryPool->tbr_pallet)+($request->tbr_pallet));
                $InventoryPool->save();
            }

            if($transporter_id!=null){
                $InventoryTrans = Transporter::find($transporter_id);
                $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)-($request->tbr_pallet));
                $InventoryTrans->tbr_pallet = (($InventoryTrans->tbr_pallet)+($request->tbr_pallet));
                $InventoryTrans->save();
            }
    
            $data = [
                'data' => $damagedpallet,
                'status' => (bool) $damagedpallet,
                'message' => $damagedpallet ? 'Damaged Pallet Record Created!' : 'Error Damaged Pallet Record' 
            ];
    
            return response()->json($data);
        }
        
    }

    public function destroy($id)
    {
        $damagedpallet = Damagedpallet::find($id); //QUERY DATA BERDASARKAN ID
        $damagedpallet->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }
}
