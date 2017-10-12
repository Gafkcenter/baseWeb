package com.gafker.www.security.message.digest.securityweb;

import org.apache.commons.codec.digest.DigestUtils;

/**
 * MD5...
 * 消息摘要算法：MD 消息摘要算法,SHA 安全散列算法,MAC 消息认证码算法 功能：功能常用于验证数据的完整性，是数据库签名的核心算法，密码验证
 * 方向：单向
 * 作用：一致信效验。
 * @author gafker
 *
 */
public class WebSecDemo {
	public static String password = "admin";
	//盐值必须为一个不变值
	public static String shaSalt = "HardConstantStatic";

	public static void main(String[] args) {
		md5Password();
		sha1PasswordSalt();
	}

	/**
	 * MD5 简单的安全摘要算法
	 * Web安全方案一：数据库内密码加密用,缺陷：MD5使用普遍,当今数据库帐号密码权限较大知道数据库密码即直接修改用户密码.
	 */
	public static void md5Password() {
		String md5String = DigestUtils.md5Hex(password);
		System.out.println("加密前：" + password + "\t加密后：" + md5String);
	}

	/**
	 * SHA1 安全散列算法 加盐值
	 * Web安全方案二：SHA1加入用户自己保存的固定盐值,黑客破解密码难度变难。
	 */
	public static void sha1PasswordSalt() {
		String md5String = DigestUtils.sha1Hex(password+shaSalt);
		System.out.println("加密前：" + password + "\t加密后：" + md5String);
	}
}
