<table>
    <thead>
        <tr>
            <th colspan="2"><strong>TUFPAL SYSTEM ALL TRANSACTION {{ date('Y-m-d') }} </strong></th>
        </tr>
        <tr>
            <th colspan="2"></th>
        </tr>
        <tr>
            <th>TID Number</th>
            <th>SJP Number</th>
            <th>SJPS Number</th>
            <th>TP Number</th>
            <th>BMP Number</th>
            <th>NP Number</th>
            <th>DP Number</th>
            <th>RP Number</th>
            <th>Transaction</th>
            <th>No Dispatch</th>
            <th>New No Dispatch</th>
            <th>Status</th>
            <th>Departure Pool</th>
            <th>Destination Pool</th>
            <th>New Destination</th>
            <th>Pool Pallet</th>
            <th>Transporter</th>
            <th>Vehicle</th>
            <th>New Vehicle</th>
            <th>Driver</th>
            <th>New Driver</th>
            <th>Good Pallet</th>
            <th>TBR Pallet</th>
            <th>BER Pallet</th>
            <th>Missing Pallet</th>
            <th>Good Cement</th>
            <th>Bad Cement</th>
            <th>Reason</th>
            <th>Note</th>
            <th>Created At</th>
            
        </tr>
    </thead>
    <tbody>
        @foreach($alltransaction as $row)
            <tr>
                <td>{{ $row -> tid_number }}</td>
                <td>{{ $row -> sjp_number }}</td>
                <td>{{ $row -> sjps_number }}</td>
                <td>{{ $row -> tp_number }}</td>
                <td>{{ $row -> bmp_number }}</td>
                <td>{{ $row -> np_number }}</td>
                <td>{{ $row -> dp_number }}</td>
                <td>{{ $row -> rp_number }}</td>
                <td>{{ $row -> transaction }}</td>
                <td>{{ $row -> no_do }}</td>
                <td>{{ $row -> new_no_do }}</td>
                <td>{{ $row -> status }}</td>
                <td>{{ $row -> departure_pool }}</td>
                <td>{{ $row -> destination_pool }}</td>
                <td>{{ $row -> new_destination }}</td>
                <td>{{ $row -> pool_pallet }}</td>
                <td>{{ $row -> transporter }}</td>
                <td>{{ $row -> vehicle }}</td>
                <td>{{ $row -> new_vehicle }}</td>
                <td>{{ $row -> driver }}</td>
                <td>{{ $row -> new_driver }}</td>
                <td>{{ number_format($row -> good_pallet) }} </td>
                <td>{{ number_format($row -> tbr_pallet) }} </td>
                <td>{{ number_format($row -> ber_pallet) }} </td>
                <td>{{ number_format($row -> missing_pallet) }} </td>
                <td>{{ number_format($row -> good_cement) }} </td>
                <td>{{ number_format($row -> bad_cement) }} </td>
                <td>{{ $row -> reason }}</td>
                <td>{{ $row -> note }}</td>
                <td>{{ $row -> created_at }}</td>
            </tr>
        @endforeach
    </tbody>
</table>