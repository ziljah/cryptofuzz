const io = @import("std").io;
const std = @import("std");
const Limb = std.math.big.Limb;
const mem = std.mem;
const hkdf = std.crypto.kdf.hkdf;
const pbkdf2 = std.crypto.pwhash.pbkdf2;
const HmacSha1 = std.crypto.auth.hmac.HmacSha1;
const scrypt = std.crypto.pwhash.scrypt;
const hash = std.crypto.hash;
const hmac = std.crypto.auth.hmac;

export fn cryptofuzz_zig_digest(
        res_data: [*:0]u8,
        cleartext_data: [*:0]const u8,
        parts_start: [*:0]const u32,
        parts_end: [*:0]const u32,
        parts_size: u32,
        digest: u32) callconv(.C) i32 {
    var i: u32 = 0;

    if (digest == 0) {
        var h = hash.Md5.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..16]);
        return 16;
    } else if (digest == 1) {
        var h = hash.Sha1.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..20]);
        return 20;
    } else if (digest == 2) {
        var h = hash.sha2.Sha224.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..28]);
        return 28;
    } else if (digest == 3) {
        var h = hash.sha2.Sha256.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..32]);
        return 32;
    } else if (digest == 4) {
        var h = hash.sha2.Sha384.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..48]);
        return 48;
    } else if (digest == 5) {
        var h = hash.sha2.Sha512.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..64]);
        return 64;
    } else if (digest == 6) {
        var h = hash.blake2.Blake2b128.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..16]);
        return 16;
    } else if (digest == 7) {
        var h = hash.blake2.Blake2b160.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..20]);
        return 20;
    } else if (digest == 8) {
        var h = hash.blake2.Blake2b256.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..32]);
        return 32;
    } else if (digest == 9) {
        var h = hash.blake2.Blake2b384.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..48]);
        return 48;
    } else if (digest == 10) {
        var h = hash.blake2.Blake2b512.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..64]);
        return 64;
    } else if (digest == 11) {
        var h = hash.blake2.Blake2s128.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..16]);
        return 16;
    } else if (digest == 12) {
        var h = hash.blake2.Blake2s160.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..20]);
        return 20;
    } else if (digest == 13) {
        var h = hash.blake2.Blake2s256.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..32]);
        return 32;
    } else if (digest == 14) {
        var h = hash.Blake3.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..32]);
        return 32;
    } else if (digest == 15) {
        var h = hash.sha3.Sha3_224.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..28]);
        return 28;
    } else if (digest == 16) {
        var h = hash.sha3.Sha3_256.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..32]);
        return 32;
    } else if (digest == 17) {
        var h = hash.sha3.Sha3_384.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..48]);
        return 48;
    } else if (digest == 18) {
        var h = hash.sha3.Sha3_512.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..64]);
        return 64;
    } else if (digest == 19) {
        var h = hash.sha3.Keccak_256.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..32]);
        return 32;
    } else if (digest == 20) {
        var h = hash.sha3.Keccak_512.init(.{});
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..64]);
        return 64;
    } else {
        return -1;
    }
}

export fn cryptofuzz_zig_hmac(
        res_data: [*:0]u8,
        key_data: [*:0]const u8, key_size: u32,
        cleartext_data: [*:0]const u8,
        parts_start: [*:0]const u32,
        parts_end: [*:0]const u32,
        parts_size: u32,
        digest: u32) callconv(.C) i32 {
    var i: u32 = 0;

    if (digest == 0) {
        var h = hmac.Hmac(hash.Md5).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..16]);
        return 16;
    } else if (digest == 1) {
        var h = hmac.Hmac(hash.Sha1).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..20]);
        return 20;
    } else if (digest == 2) {
        var h = hmac.Hmac(hash.sha2.Sha224).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..28]);
        return 28;
    } else if (digest == 3) {
        var h = hmac.Hmac(hash.sha2.Sha256).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..32]);
        return 32;
    } else if (digest == 4) {
        var h = hmac.Hmac(hash.sha2.Sha384).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..48]);
        return 48;
    } else if (digest == 5) {
        var h = hmac.Hmac(hash.sha2.Sha512).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..64]);
        return 64;
    } else if (digest == 6) {
        var h = hmac.Hmac(hash.blake2.Blake2b128).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..16]);
        return 16;
    } else if (digest == 7) {
        var h = hmac.Hmac(hash.blake2.Blake2b160).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..20]);
        return 20;
    } else if (digest == 8) {
        var h = hmac.Hmac(hash.blake2.Blake2b256).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..32]);
        return 32;
    } else if (digest == 9) {
        var h = hmac.Hmac(hash.blake2.Blake2b384).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..48]);
        return 48;
    } else if (digest == 10) {
        var h = hmac.Hmac(hash.blake2.Blake2b512).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..64]);
        return 64;
    } else if (digest == 11) {
        var h = hmac.Hmac(hash.blake2.Blake2s128).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..16]);
        return 16;
    } else if (digest == 12) {
        var h = hmac.Hmac(hash.blake2.Blake2s160).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..20]);
        return 20;
    } else if (digest == 13) {
        var h = hmac.Hmac(hash.blake2.Blake2s256).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..32]);
        return 32;
    } else if (digest == 14) {
        var h = hmac.Hmac(hash.Blake3).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..32]);
        return 32;
    } else if (digest == 15) {
        var h = hmac.Hmac(hash.sha3.Sha3_224).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..28]);
        return 28;
    } else if (digest == 16) {
        var h = hmac.Hmac(hash.sha3.Sha3_256).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..32]);
        return 32;
    } else if (digest == 17) {
        var h = hmac.Hmac(hash.sha3.Sha3_384).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..48]);
        return 48;
    } else if (digest == 18) {
        var h = hmac.Hmac(hash.sha3.Sha3_512).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..64]);
        return 64;
    } else if (digest == 19) {
        var h = hmac.Hmac(hash.sha3.Keccak_256).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..32]);
        return 32;
    } else if (digest == 20) {
        var h = hmac.Hmac(hash.sha3.Keccak_512).init(key_data[0..key_size]);
        while (i < parts_size): (i+=1) {
            h.update(cleartext_data[parts_start[i]..parts_end[i]]);
        }
        h.final(res_data[0..64]);
        return 64;
    } else {
        return -1;
    }
}

export fn cryptofuzz_zig_hkdf(
        res_data: [*:0]u8, res_size: u32,
        password_data: [*:0]const u8, password_size: u32,
        salt_data: [*:0]const u8, salt_size: u32,
        info_data: [*:0]const u8, info_size: u32,
        digest: u32) callconv(.C) i32 {
    if ( digest == 0 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.Md5)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.Md5)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 1 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.Sha1)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.Sha1)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 2 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.sha2.Sha224)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.sha2.Sha224)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 3 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.sha2.Sha256)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.sha2.Sha256)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 4 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.sha2.Sha384)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.sha2.Sha384)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 5 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.sha2.Sha512)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.sha2.Sha512)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 6 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.blake2.Blake2b128)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.blake2.Blake2b128)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 7 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.blake2.Blake2b160)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.blake2.Blake2b160)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 8 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.blake2.Blake2b256)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.blake2.Blake2b256)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 9 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.blake2.Blake2b384)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.blake2.Blake2b384)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 10 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.blake2.Blake2b512)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.blake2.Blake2b512)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 11 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.blake2.Blake2s128)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.blake2.Blake2s128)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 12 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.blake2.Blake2s160)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.blake2.Blake2s160)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 13 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.blake2.Blake2s256)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.blake2.Blake2s256)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 14 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.Blake3)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.Blake3)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 15 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.sha3.Sha3_224)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.sha3.Sha3_224)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 16 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.sha3.Sha3_256)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.sha3.Sha3_256)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 17 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.sha3.Sha3_384)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.sha3.Sha3_384)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 18 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.sha3.Sha3_512)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.sha3.Sha3_512)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 19 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.sha3.Keccak_256)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.sha3.Keccak_256)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    } else if ( digest == 20 ) {
        const prk = hkdf.Hkdf(hmac.Hmac(hash.sha3.Keccak_512)).extract(
                salt_data[0..salt_size],
                password_data[0..password_size]);
        hkdf.Hkdf(hmac.Hmac(hash.sha3.Keccak_512)).expand(
                res_data[0..res_size],
                info_data[0..info_size],
                prk);
        return 0;
    }
    return -1;
}

export fn cryptofuzz_zig_pbkdf2(
        res_data: [*:0]u8, res_size: u32,
        password_data: [*:0]const u8, password_size: u32,
        salt_data: [*:0]const u8, salt_size: u32,
        iterations: u32,
        digest: u32) callconv(.C) i32 {
    if ( digest == 0 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.Md5)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 1 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.Sha1)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 2 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.sha2.Sha224)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 3 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.sha2.Sha256)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 4 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.sha2.Sha384)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 5 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.sha2.Sha512)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 6 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.blake2.Blake2b128)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 7 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.blake2.Blake2b160)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 8 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.blake2.Blake2b256)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 9 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.blake2.Blake2b384)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 10 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.blake2.Blake2b512)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 11 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.blake2.Blake2s128)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 12 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.blake2.Blake2s160)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 13 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.blake2.Blake2s256)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 14 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.Blake3)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 15 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.sha3.Sha3_224)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 16 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.sha3.Sha3_256)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 17 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.sha3.Sha3_384)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 18 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.sha3.Sha3_512)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 19 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.sha3.Keccak_256)) catch {
            return -1;
        };
        return 0;
    } else if ( digest == 20 ) {
        pbkdf2(
                res_data[0..res_size],
                password_data[0..password_size],
                salt_data[0..salt_size],
                iterations,
                hmac.Hmac(hash.sha3.Keccak_512)) catch {
            return -1;
        };
        return 0;
    }
    return -1;
}

export fn cryptofuzz_zig_scrypt(
        res_data: [*:0]u8, res_size: u32,
        password_data: [*:0]const u8, password_size: u32,
        salt_data: [*:0]const u8, salt_size: u32,
        n: u32,
        r: u32,
        p: u32) callconv(.C) i32 {
    const allocator = std.heap.page_allocator;
    scrypt.kdf(
            allocator,
            res_data[0..res_size],
            password_data[0..password_size],
            salt_data[0..salt_size],
            scrypt.Params{
                .ln = @intCast(u6, n),
                .r = @intCast(u30, r),
                .p = @intCast(u30, p)},
    ) catch {
        return -1;
    };

    return 0;
}

export fn cryptofuzz_zig_bignumcalc(
        res_data: [*:0]u8, res_size: u32,
        a_data: [*:0]const u8, a_size: u32,
        b_data: [*:0]const u8, b_size: u32,
        op: u64,
        ) callconv(.C) i32 {
    const allocator = std.heap.page_allocator;

    var a = std.math.big.int.Managed.initSet(allocator, @as(usize, 1)) catch unreachable;
    defer a.deinit();

    var b = std.math.big.int.Managed.initSet(allocator, @as(usize, 1)) catch unreachable;
    defer b.deinit();

    var res = std.math.big.int.Managed.initSet(allocator, @as(usize, 1)) catch unreachable;
    defer res.deinit();

    a.setString(10, a_data[0..a_size]) catch unreachable;
    b.setString(10, b_data[0..b_size]) catch unreachable;

    if ( op == 0 ) {
        res.add(&a, &b) catch unreachable;
    } else if ( op == 1 ) {
        res.sub(&a, &b) catch unreachable;
    } else if ( op == 2 ) {
        res.mul(&a, &b) catch unreachable;
    } else if ( op == 3 ) {
        if ( !a.isPositive() ) {
            return 1;
        }
        if ( !b.isPositive()) {
            return 1;
        }
        if ( b.eqZero() ) {
            return 1;
        }

        var mod = std.math.big.int.Managed.initSet(allocator, @as(usize, 1)) catch unreachable;
        defer mod.deinit();

        res.divFloor(&mod, &a, &b) catch unreachable;
    } else if ( op == 4 ) {
        if ( !a.isPositive() ) {
            return 1;
        }
        if ( !b.isPositive() ) {
            return 1;
        }
        if ( a.eqZero() ) {
            return 1;
        }
        if ( b.eqZero() ) {
            return 1;
        }
        //res.gcd(a, b) catch unreachable;
        res.gcd(&a, &b) catch {
            return 1;
        };
    } else if ( op == 5) {
        res.sqr(&a) catch unreachable;
    } else if ( op == 6 ) {
        if ( !a.isPositive() ) {
            return 1;
        }
        if ( !b.isPositive() ) {
            return 1;
        }
        if ( b.eqZero() ) {
            return 1;
        }

        var mod = std.math.big.int.Managed.initSet(allocator, @as(usize, 1)) catch unreachable;
        defer mod.deinit();

        res.divFloor(&mod, &a, &b) catch unreachable;
        res.swap(&mod);
    } else if ( op == 7 ) {
        res.shiftLeft(&a, 1) catch unreachable;
    } else if ( op == 8 ) {
        res.bitAnd(&a, &b) catch unreachable;
    } else if ( op == 9 ) {
        res.bitOr(&a, &b) catch unreachable;
    } else if ( op == 10 ) {
        res.bitXor(&a, &b) catch unreachable;
    } else if ( op == 11 ) {
        a.negate();
        res.copy(a.toConst()) catch unreachable;
    } else if ( op == 12 ) {
        a.abs();
        res.copy(a.toConst()) catch unreachable;
    } else if ( op == 13 ) {
        res.set(a.bitCountAbs()) catch unreachable;
    } else if ( op == 14 ) {
        var count = b.to(usize) catch {
            return 1;
        };
        res.shiftRight(&a, count) catch unreachable;
    } else if ( op == 15 ) {
        var power = b.to(u32) catch {
            return 1;
        };
        res.pow(&a, power) catch unreachable;
    } else {
        return 1;
    }

    var s = res.toString(allocator, 10, .lower) catch unreachable;
    mem.copy(u8, res_data[0..res_size], s);
    allocator.free(s);

    return 0;
}
