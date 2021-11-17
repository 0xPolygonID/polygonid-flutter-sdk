// WARNING still updating the code, it works, but is still in process the refactor.

pub mod eddsa;

use poseidon_rs::Poseidon;
pub type Fr = poseidon_rs::Fr;

#[macro_use]
extern crate ff;

#[macro_use]
extern crate arrayref;
extern crate generic_array;
//extern crate mimc_rs;
extern crate num;
extern crate num_bigint;
extern crate num_traits;
extern crate rand6;
extern crate rand;
extern crate blake; // compatible version with Blake used at circomlib
#[macro_use]
extern crate lazy_static;

use ff::*;
use std::str;

use crate::eddsa::{Signature, decompress_point, Point, PrivateKey, verify, decompress_signature, /*compress_point,*/ PointProjective, Q, B8, new_key};
use num_bigint::{Sign, BigInt, ToBigInt};
use std::os::raw::{c_char};
use std::ffi::{CStr, CString};
use std::cmp::min;
use std::str::FromStr;
use num_traits::{Num, ToPrimitive};
use rustc_hex::{FromHex, ToHex};
use num::Zero;

/*lazy_static! {
 static ref B8: Point = Point {
        x: Fr::from_str(
            "5299619240641551281634865583518297030282874472190772894086521144482721001553",
        )
        .unwrap(),
        y: Fr::from_str(
            "16950150798460657717958625567821834550301663161624707787222815936182638968203",
        )
        .unwrap(),
        // z: Fr::one(),
    };
}*/

#[no_mangle]
pub extern fn pack_signature(signature: *const c_char) -> *mut c_char {
    let signature_cstr = unsafe { CStr::from_ptr(signature) };
    let signature_str = match signature_cstr.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };
    let signature_bytes_raw = signature_str.from_hex().unwrap();
    let mut signature_bytes: [u8; 64] = [0; 64];
    signature_bytes.copy_from_slice(&signature_bytes_raw);

    let r_b8_bytes: [u8; 32] = *array_ref!(signature_bytes[..32], 0, 32);
    let s: BigInt = BigInt::from_bytes_le(Sign::Plus, &signature_bytes[32..]);

    //let x_big = BigInt::parse_bytes(&r_b8_bytes[..16], 16).unwrap();
    //let y_big = BigInt::parse_bytes(&r_b8_bytes[16..], 16).unwrap();
    /*let (_, x_bytes) = x_big.to_bytes_le();
    let (_, y_bytes) = y_big.to_bytes_le();

    let mut x_16bytes: [u8; 16] = [0; 16];
    let lenx = min(x_bytes.len(), x_16bytes.len());
    x_16bytes[..lenx].copy_from_slice(&x_bytes[..lenx]);
    b.append(&mut x_16bytes.to_vec());

    let mut y_16bytes: [u8; 16] = [0; 16];
    let leny = min(y_bytes.len(), y_16bytes.len());
    y_16bytes[..leny].copy_from_slice(&y_bytes[..leny]);
    b.append(&mut y_16bytes.to_vec());*/


    //let x_string = to_hex_string(r_b8_bytes[..16].to_vec());
    //let x_str = x_string.as_str();
    //let y_string = to_hex_string(r_b8_bytes[16..].to_vec());

    //let r_b8 = decompress_point(r_b8_bytes).unwrap();
    //let y_str = y_string.as_str();
    //let x_big = BigInt::parse_bytes(&r_b8_bytes[0..15], 16).unwrap();
    //let y_big = BigInt::parse_bytes(&r_b8_bytes[15..32], 16).unwrap();
    let x_big: BigInt = BigInt::from_bytes_le(Sign::Plus, &r_b8_bytes[0..15]);
    let y_big: BigInt = BigInt::from_bytes_le(Sign::Plus, &r_b8_bytes[15..32]);
    //let y_big = x_big.clone();

    let r_b8: Point = Point {
        x: Fr::from_str(
            &x_big.to_string(),
        ).unwrap(),
        y: Fr::from_str(
            &y_big.to_string(),
        ).unwrap(),
    };

    let sig = Signature { r_b8 : r_b8.clone(), s };
    let res = sig.compress();

    let hex_string = to_hex_string(res.to_vec());
    CString::new(hex_string.as_str()).unwrap().into_raw()
}

#[no_mangle]
pub extern fn unpack_signature(compressed_signature: *const c_char) -> *mut c_char {
    let compressed_signature_cstr = unsafe { CStr::from_ptr(compressed_signature) };
    let compressed_signature_str = match compressed_signature_cstr.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };
    let compressed_signature_bytes_raw = compressed_signature_str.from_hex().unwrap();
    let mut compressed_signature_bytes: [u8; 64] = [0; 64];
    compressed_signature_bytes.copy_from_slice(&compressed_signature_bytes_raw);
    let decompressed_sig = decompress_signature(&compressed_signature_bytes).unwrap();

    let mut b: Vec<u8> = Vec::new();

    let x_big = BigInt::parse_bytes(to_hex(&decompressed_sig.r_b8.x).as_bytes(), 16).unwrap();
    let y_big = BigInt::parse_bytes(to_hex(&decompressed_sig.r_b8.y).as_bytes(), 16).unwrap();
    let (_, x_bytes) = x_big.to_bytes_le();
    let (_, y_bytes) = y_big.to_bytes_le();

    let mut x_16bytes: [u8; 16] = [0; 16];
    let lenx = min(x_bytes.len(), x_16bytes.len());
    x_16bytes[..lenx].copy_from_slice(&x_bytes[..lenx]);
    b.append(&mut x_16bytes.to_vec());

    let mut y_16bytes: [u8; 16] = [0; 16];
    let leny = min(y_bytes.len(), y_16bytes.len());
    y_16bytes[..leny].copy_from_slice(&y_bytes[..leny]);
    b.append(&mut y_16bytes.to_vec());

    let (_, s_bytes) = decompressed_sig.s.to_bytes_le();
    let mut s_32bytes: [u8; 32] = [0; 32];
    let lens = min(s_bytes.len(), s_32bytes.len());
    s_32bytes[..lens].copy_from_slice(&s_bytes[..lens]);
    b.append(&mut s_32bytes.to_vec());

    let mut r: [u8; 64] = [0; 64];
    let res_len = min(r.len(), b.len());
    r[..res_len].copy_from_slice(&b[..res_len]);

    let hex_string = to_hex_string(r.to_vec());
    CString::new(hex_string.as_str()).unwrap().into_raw()
}

fn vector_as_u8_64_array(vector: Vec<u8>) -> [u8; 64] {
    let mut arr = [0u8;64];
    for (place, element) in arr.iter_mut().zip(vector.iter()) {
        *place = *element;
    }
    arr
}

#[no_mangle]
pub extern fn pack_point(point_x: *const c_char, point_y: *const c_char) -> *mut c_char {
    let point_x_cstr = unsafe { CStr::from_ptr(point_x) };
    let point_x_str = match point_x_cstr.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };
    let point_y_cstr = unsafe { CStr::from_ptr(point_y) };
    let point_y_str = match point_y_cstr.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };
    let p: Point = Point {
        x: Fr::from_str(point_x_str).unwrap(),
        y: Fr::from_str(point_y_str).unwrap(),
    };

    let compressed_point = p.compress();
    let hex_string = to_hex_string(compressed_point.to_vec());
    CString::new(hex_string.as_str()).unwrap().into_raw()
}

pub fn to_hex_string(bytes: Vec<u8>) -> String {
    let strs: Vec<String> = bytes.iter()
        .map(|b| format!("{:02X}", b))
        .collect();
    strs.join("")
}

#[no_mangle]
pub extern fn unpack_point(compressed_point: *const c_char) ->  *mut c_char {
    let compressed_point_str = unsafe { CStr::from_ptr(compressed_point) }.to_str().unwrap();
    let y_bytes_raw = compressed_point_str.from_hex().unwrap();
    let mut y_bytes: [u8; 32] = [0; 32];
    y_bytes.copy_from_slice(&y_bytes_raw);
    let p = decompress_point(y_bytes).unwrap();
    let x_big = BigInt::parse_bytes(to_hex(&p.x).as_bytes(), 16).unwrap();
    let y_big = BigInt::parse_bytes(to_hex(&p.y).as_bytes(), 16).unwrap();
    let mut result_string: String = "".to_owned();
    result_string.push_str(&x_big.to_string());
    result_string.push_str(",");
    result_string.push_str(&y_big.to_string());
    CString::new(result_string.as_str()).unwrap().into_raw()
}

#[no_mangle]
pub extern fn prv2pub(private_key: *const c_char) -> *mut c_char {
    /*let private_key_bytes: [u8; 32] = *array_ref!(private_key[..32], 0, 32);
    let private_key = PrivateKey::import(private_key_bytes.to_vec()).unwrap();*/
    let private_key_str = unsafe { CStr::from_ptr(private_key) }.to_str().unwrap();
    //let pk_bigint = BigInt::from_str(private_key_str).unwrap();
    let pk_bytes_raw = private_key_str.from_hex().unwrap();
    let mut pk_bytes: [u8; 32] = [0; 32];
    pk_bytes.copy_from_slice(&pk_bytes_raw);
    let pk = PrivateKey { key: pk_bytes };
    let public_key = pk.public();
    let mut result_string: String = "".to_owned();
    result_string.push_str(&public_key.x.to_string());
    result_string.push_str(",");
    result_string.push_str(&public_key.y.to_string());
    CString::new(result_string.as_str()).unwrap().into_raw()
}

#[no_mangle]
pub extern fn hash_poseidon(tx_compressed_data: *const c_char, to_eth_addr: *const c_char, to_bjj_ay: *const c_char, rq_txcompressed_data_v2: *const c_char, rq_to_eth_addr: *const c_char, rq_to_bjj_ay: *const c_char) -> *mut c_char {
    let tx_compressed_data_str = unsafe { CStr::from_ptr(tx_compressed_data) }.to_str().unwrap();
    let b0: Fr = Fr::from_str(tx_compressed_data_str).unwrap();
    let to_eth_addr_str = unsafe { CStr::from_ptr(to_eth_addr) }.to_str().unwrap();
    let b1: Fr = Fr::from_str(to_eth_addr_str).unwrap();
    let to_bjj_ay_str = unsafe { CStr::from_ptr(to_bjj_ay) }.to_str().unwrap();
    let b2: Fr = Fr::from_str(to_bjj_ay_str).unwrap();
    let rq_txcompressed_data_v2_str = unsafe { CStr::from_ptr(rq_txcompressed_data_v2) }.to_str().unwrap();
    let b3: Fr = Fr::from_str(rq_txcompressed_data_v2_str).unwrap();
    let rq_to_eth_addr_str = unsafe { CStr::from_ptr(rq_to_eth_addr) }.to_str().unwrap();
    let b4: Fr = Fr::from_str(rq_to_eth_addr_str).unwrap();
    let rq_to_bjj_ay_str = unsafe { CStr::from_ptr(rq_to_bjj_ay) }.to_str().unwrap();
    let b5: Fr = Fr::from_str(rq_to_bjj_ay_str).unwrap();

    let hm_input = vec![b0.clone(), b1.clone(), b2.clone(), b3.clone(), b4.clone(), b5.clone()];
    let poseidon = Poseidon::new();
    let hm = poseidon.hash(hm_input).unwrap();
    return CString::new(to_hex(&hm).as_str()).unwrap().into_raw();
}

#[no_mangle]
pub extern fn sign_poseidon(private_key: *const c_char, msg: *const c_char) -> *mut c_char {
    let private_key_str = unsafe { CStr::from_ptr(private_key) }.to_str().unwrap();
    //let pk_bigint = BigInt::from_str(private_key_str).unwrap();
    let pk_bytes_raw = private_key_str.from_hex().unwrap();
    let mut pk_bytes: [u8; 32] = [0; 32];
    pk_bytes.copy_from_slice(&pk_bytes_raw);
    let pk = PrivateKey { key: pk_bytes };
    let message_str = unsafe { CStr::from_ptr(msg) }.to_str().unwrap();
    let message_bigint = BigInt::from_str(message_str).unwrap();
    let sig = pk.sign(message_bigint.clone()).unwrap();
    let compressed_signature = sig.compress();
    let hex_string = compressed_signature.to_hex();
    CString::new(hex_string.as_str()).unwrap().into_raw()
}

#[no_mangle]
pub extern fn verify_poseidon(private_key: *const c_char, compressed_signature: *const c_char, message: *const c_char) ->  *mut c_char {
    let private_key_str = unsafe { CStr::from_ptr(private_key) }.to_str().unwrap();
    // let pk_bigint = BigInt::from_str(private_key_str).unwrap();
    let pk_bytes_raw = private_key_str.from_hex().unwrap();
    let mut pk_bytes: [u8; 32] = [0; 32];
    pk_bytes.copy_from_slice(&pk_bytes_raw);
    let pk = PrivateKey { key: pk_bytes };
    let compressed_signature_str = unsafe { CStr::from_ptr(compressed_signature) }.to_str().unwrap();
    let signature_bytes_raw = compressed_signature_str.from_hex().unwrap();
    let mut signature_bytes: [u8; 64] = [0; 64];
    signature_bytes.copy_from_slice(&signature_bytes_raw);
    let sig = decompress_signature(&signature_bytes).unwrap();
    let message_c_str = unsafe { CStr::from_ptr(message) };
    let message_str = match message_c_str.to_str() {
        Err(_) => "there",
        Ok(string) => string,
    };
    let message_bigint = match message_str.parse::<i32>() {
        Ok(n) => BigInt::from(n),
        Err(e) => BigInt::zero(),
    };

    if verify(pk.public(), sig.clone(), message_bigint.clone()) {
        CString::new("1".to_owned()).unwrap().into_raw()
    } else {
        CString::new("0".to_owned()).unwrap().into_raw()
    }
}

#[no_mangle]
pub extern fn cstring_free(str: *mut c_char) {
    unsafe {
        if str.is_null() { return }
        CString::from_raw(str)
    };
}