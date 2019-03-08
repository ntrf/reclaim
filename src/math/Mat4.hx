package math;

import haxe.io.Float32Array;

abstract Mat4(Float32Array) to haxe.io.Float32Array {

	inline static var GLMAT_EPSILON : Float = 0.1; //TODO check gl-matrix constants

	inline public function new() {
		this = new Float32Array(16);
		this[0] = 1;
		this[1] = 0;
		this[2] = 0;
		this[3] = 0;
		this[4] = 0;
		this[5] = 1;
		this[6] = 0;
		this[7] = 0;
		this[8] = 0;
		this[9] = 0;
		this[10] = 1;
		this[11] = 0;
		this[12] = 0;
		this[13] = 0;
		this[14] = 0;
		this[15] = 1;
	}

	public var backward(get, set) : Vec3;
	inline function get_backward() { return new Vec3(this[8], this[9], this[10]); }
	inline function set_backward(v : Vec3) { this[8] = v.x; this[9] = v.y; this[10] = v.z; return v; }

	public var right(get, set) : Vec3;
	inline function get_right() { return new Vec3(this[0], this[1], this[2]); }
	inline function set_right(v : Vec3) { this[0] = v.x; this[1] = v.y; this[2] = v.z; return v; }

	public var up(get, set) : Vec3;
	inline function get_up() { return new Vec3(this[4], this[5], this[6]); }
	inline function set_up(v : Vec3) { this[4] = v.x; this[5] = v.y; this[6] = v.z; return v; }

	public var position(get, set) : Vec3;
	inline function get_position() { return new Vec3(this[12], this[13], this[14]); }
	inline function set_position(v : Vec3) { this[12] = v.x; this[13] = v.y; this[14] = v.z; return v; }

	@:arrayAccess
	public inline function getElement(index : Int) {
		return this[index];
	} 
	
	@:arrayAccess 
	public inline function setElement(index : Int, v : Float) : Float {
		this[index] =  v;
		return v;
	}

	/**
	 * Set a mat4 to the identity matrix
	 *
	 * @param {mat4} out the receiving matrix
	 * @returns {mat4} out
	 */
	public static function identity(out : Mat4) {
		out[0] = 1;
		out[1] = 0;
		out[2] = 0;
		out[3] = 0;
		out[4] = 0;
		out[5] = 1;
		out[6] = 0;
		out[7] = 0;
		out[8] = 0;
		out[9] = 0;
		out[10] = 1;
		out[11] = 0;
		out[12] = 0;
		out[13] = 0;
		out[14] = 0;
		out[15] = 1;
		return out;
	}

	/**
	 * Copy the values from one Mat4 to another
 	 *
 	 * @param {Mat4} out the receiving matrix
	 * @param {Mat4} a the source matrix
 	 * @returns {Mat4} out
	**/
	public static function copyFrom(out : Mat4, a : Mat4) : Mat4 {
		out[0] = a[0];
		out[1] = a[1];
		out[2] = a[2];
		out[3] = a[3];
		out[4] = a[4];
		out[5] = a[5];
		out[6] = a[6];
		out[7] = a[7];
		out[8] = a[8];
		out[9] = a[9];
		out[10] = a[10];
		out[11] = a[11];
		out[12] = a[12];
		out[13] = a[13];
		out[14] = a[14];
		out[15] = a[15];
		return out;	
	}

	/**
	 * Create clone of current matrix
	 */
	public function clone()
	{
		var r = new Mat4();
		r[0] = this[0];
		r[1] = this[1];
		r[2] = this[2];
		r[3] = this[3];
		r[4] = this[4];
		r[5] = this[5];
		r[6] = this[6];
		r[7] = this[7];
		r[8] = this[8];
		r[9] = this[9];
		r[10] = this[10];
		r[11] = this[11];
		r[12] = this[12];
		r[13] = this[13];
		r[14] = this[14];
		r[15] = this[15];
		return r;
	}

	public function toString()
	{
		return '${this[0]}  ${this[1]}  ${this[2]}  ${this[3]}\n'+
			'${this[4]}  ${this[5]}  ${this[6]}  ${this[7]}\n' + 
			'${this[8]}  ${this[9]}  ${this[10]}  ${this[11]}\n' +
			'${this[12]}  ${this[13]}  ${this[14]}  ${this[15]}';
	}

	/**
	 * Multiplies two mat4's
	 *
	 * @param {mat4} out the receiving matrix
	 * @param {mat4} a the first operand
	 * @param {mat4} b the second operand
	 * @returns {mat4} out
	 */
	public static function multiply(out : Mat4, a : Mat4, b : Mat4) {
		var a00 = a[0], a01 = a[1], a02 = a[2], a03 = a[3],
			a10 = a[4], a11 = a[5], a12 = a[6], a13 = a[7],
			a20 = a[8], a21 = a[9], a22 = a[10], a23 = a[11],
			a30 = a[12], a31 = a[13], a32 = a[14], a33 = a[15];

		// Cache only the current line of the second matrix
		var b0  = b[0], b1 = b[1], b2 = b[2], b3 = b[3];  
		out[0] = b0*a00 + b1*a10 + b2*a20 + b3*a30;
		out[1] = b0*a01 + b1*a11 + b2*a21 + b3*a31;
		out[2] = b0*a02 + b1*a12 + b2*a22 + b3*a32;
		out[3] = b0*a03 + b1*a13 + b2*a23 + b3*a33;

		b0 = b[4]; b1 = b[5]; b2 = b[6]; b3 = b[7];
		out[4] = b0*a00 + b1*a10 + b2*a20 + b3*a30;
		out[5] = b0*a01 + b1*a11 + b2*a21 + b3*a31;
		out[6] = b0*a02 + b1*a12 + b2*a22 + b3*a32;
		out[7] = b0*a03 + b1*a13 + b2*a23 + b3*a33;

		b0 = b[8]; b1 = b[9]; b2 = b[10]; b3 = b[11];
		out[8] = b0*a00 + b1*a10 + b2*a20 + b3*a30;
		out[9] = b0*a01 + b1*a11 + b2*a21 + b3*a31;
		out[10] = b0*a02 + b1*a12 + b2*a22 + b3*a32;
		out[11] = b0*a03 + b1*a13 + b2*a23 + b3*a33;

		b0 = b[12]; b1 = b[13]; b2 = b[14]; b3 = b[15];
		out[12] = b0*a00 + b1*a10 + b2*a20 + b3*a30;
		out[13] = b0*a01 + b1*a11 + b2*a21 + b3*a31;
		out[14] = b0*a02 + b1*a12 + b2*a22 + b3*a32;
		out[15] = b0*a03 + b1*a13 + b2*a23 + b3*a33;
		return out;
	}


	/**
	 * Translate a Mat4 by the given vector
	 *
	 * @param {Mat4} out the receiving matrix
	 * @param {Mat4} a the matrix to translate
	 * //TODO @param {Vec4} v vector to translate by
	 * @returns {Mat4} out
	 **/
	public static function translate(out : Mat4, a : Mat4, x : Float, y : Float, z : Float) : Mat4{
		var a00, a01, a02, a03,
			a10, a11, a12, a13,
			a20, a21, a22, a23;

		if (a == out) {
			out[12] = a[0] * x + a[4] * y + a[8] * z + a[12];
			out[13] = a[1] * x + a[5] * y + a[9] * z + a[13];
			out[14] = a[2] * x + a[6] * y + a[10] * z + a[14];
			out[15] = a[3] * x + a[7] * y + a[11] * z + a[15];
		} else {
			a00 = a[0]; a01 = a[1]; a02 = a[2]; a03 = a[3];
			a10 = a[4]; a11 = a[5]; a12 = a[6]; a13 = a[7];
			a20 = a[8]; a21 = a[9]; a22 = a[10]; a23 = a[11];

			out[0] = a00; out[1] = a01; out[2] = a02; out[3] = a03;
			out[4] = a10; out[5] = a11; out[6] = a12; out[7] = a13;
			out[8] = a20; out[9] = a21; out[10] = a22; out[11] = a23;

			out[12] = a00 * x + a10 * y + a20 * z + a[12];
			out[13] = a01 * x + a11 * y + a21 * z + a[13];
			out[14] = a02 * x + a12 * y + a22 * z + a[14];
			out[15] = a03 * x + a13 * y + a23 * z + a[15];
		}

		return out;
	}

	/**
	 * Scales the Mat4 by the dimensions in the given Vec4
	 *
	 * @param {Mat4} out the receiving matrix
	 * @param {Mat4} a the matrix to scale
	 * //TODO @param {Vec4} v the vector to scale the matrix by
	 * @returns {Mat4} out
	 **/
	public static function scale(out : Mat4, a : Mat4, x : Float, y : Float, z : Float) : Mat4 {
		out[0] = a[0] * x;
		out[1] = a[1] * x;
		out[2] = a[2] * x;
		out[3] = a[3] * x;
		out[4] = a[4] * y;
		out[5] = a[5] * y;
		out[6] = a[6] * y;
		out[7] = a[7] * y;
		out[8] = a[8] * z;
		out[9] = a[9] * z;
		out[10] = a[10] * z;
		out[11] = a[11] * z;
		out[12] = a[12];
		out[13] = a[13];
		out[14] = a[14];
		out[15] = a[15];
		return out;
	}


	/**
	* Generates a orthogonal projection matrix with the given bounds
	*
	* @param {mat4} out mat4 frustum matrix will be written into
	* @param {number} left Left bound of the frustum
	* @param {number} right Right bound of the frustum
	* @param {number} bottom Bottom bound of the frustum
	* @param {number} top Top bound of the frustum
	* @param {number} near Near bound of the frustum
	* @param {number} far Far bound of the frustum
	* @returns {mat4} out
	*/
	static public function ortho(out : Mat4, left : Float, right : Float, bottom : Float, top : Float, near : Float, far : Float) : Mat4{
		var lr = 1 / (left - right),
		bt = 1 / (bottom - top),
		nf = 1 / (near - far);
		out[0] = -2 * lr;
		out[1] = 0;
		out[2] = 0;
		out[3] = 0;
		out[4] = 0;
		out[5] = -2 * bt;
		out[6] = 0;
		out[7] = 0;
		out[8] = 0;
		out[9] = 0;
		out[10] = 2 * nf;
		out[11] = 0;
		out[12] = (left + right) * lr;
		out[13] = (top + bottom) * bt;
		out[14] = (far + near) * nf;
		out[15] = 1;
		return out;
	}


	/**
	 * Generates a frustum matrix with the given bounds
	 *
	 * @param {mat4} out mat4 frustum matrix will be written into
	 * @param {number} left Left bound of the frustum
	 * @param {number} right Right bound of the frustum
	 * @param {number} bottom Bottom bound of the frustum
	 * @param {number} top Top bound of the frustum
	 * @param {number} near Near bound of the frustum
	 * @param {number} far Far bound of the frustum
	 * @returns {mat4} out
	 */
	static public function frustum(out : Mat4, left : Float, right : Float, bottom : Float, top : Float, near : Float, far : Float) {
		var rl = 1 / (right - left),
			tb = 1 / (top - bottom),
			nf = 1 / (near - far);
		out[0] = (near * 2) * rl;
		out[1] = 0;
		out[2] = 0;
		out[3] = 0;
		out[4] = 0;
		out[5] = (near * 2) * tb;
		out[6] = 0;
		out[7] = 0;
		out[8] = (right + left) * rl;
		out[9] = (top + bottom) * tb;
		out[10] = (far + near) * nf;
		out[11] = -1;
		out[12] = 0;
		out[13] = 0;
		out[14] = (far * near * 2) * nf;
		out[15] = 0;
		return out;
	}

	public static function rotateX(out : Mat4, a : Mat4, angle_x : Float) : Mat4{
		
		var cosX = Math.cos(angle_x);
		var sinX = Math.sin(angle_x);
	
		out[0] = a[0] ;
		out[1] = a[1] ;
		out[2] = a[2] ;
		out[3] = a[3] ;
		out[4] = a[4] * cosX + a[8] * -sinX;
		out[5] = a[5] * cosX + a[9] * -sinX;
		out[6] = a[6] * cosX + a[10] * -sinX;
		out[7] = a[7] * cosX + a[11] * -sinX;
		out[8] =  a[8] * cosX + a[4] * sinX;
		out[9] =  a[9] * cosX + a[5] * sinX;
		out[10] = a[10] * cosX + a[6] * sinX;
		out[11] = a[11] * cosX + a[7] * sinX;
		out[12] = a[12] ;
		out[13] = a[13];
		out[14] = a[14];
		out[15] = a[15];
		return out;
	}

	public static function rotateY(out : Mat4, a : Mat4, angle_y : Float) : Mat4{
		
		var cosY = Math.cos(angle_y);
		var sinY = Math.sin(angle_y);
	
		out[0] = a[0] * cosY + a[8] * sinY;
		out[1] = a[1] * cosY + a[9] * sinY;
		out[2] = a[2] * cosY + a[10] * sinY;
		out[3] = a[3] * cosY + a[11] * sinY;
		out[4] = a[4] ;
		out[5] = a[5] ;
		out[6] = a[6] ;
		out[7] = a[7] ;
		out[8] =  a[8] * cosY + a[0] * -sinY;
		out[9] =  a[9] * cosY + a[1] * -sinY;
		out[10] = a[10] * cosY + a[2] * -sinY;
		out[11] = a[11] * cosY + a[3] * -sinY;
		out[12] = a[12] ;
		out[13] = a[13];
		out[14] = a[14];
		out[15] = a[15];
		return out;
	}

	public static function rotateZ(out : Mat4, a : Mat4, angle_z : Float) : Mat4{
		
		var s = Math.sin(angle_z);
		var c = Math.cos(angle_z);
		
		var a00 = a[0],
		a01 = a[1],
		a02 = a[2],
		a03 = a[3],
		a10 = a[4],
		a11 = a[5],
		a12 = a[6],
		a13 = a[7];

		if (a != out) { // If the source and destination differ, copy the unchanged last row
			out[8]  = a[8];
			out[9]  = a[9];
			out[10] = a[10];
			out[11] = a[11];
			out[12] = a[12];
			out[13] = a[13];
			out[14] = a[14];
			out[15] = a[15];
		}

		// Perform axis-specific matrix multiplication
		out[0] = a00 * c + a10 * s;
		out[1] = a01 * c + a11 * s;
		out[2] = a02 * c + a12 * s;
		out[3] = a03 * c + a13 * s;
		out[4] = a10 * c - a00 * s;
		out[5] = a11 * c - a01 * s;
		out[6] = a12 * c - a02 * s;
		out[7] = a13 * c - a03 * s;
		return out;
	}

	public static function rotateXY(out : Mat4, angle_x : Float, angle_y : Float)
	{
		var cosX = Math.cos(angle_x);
		var sinX = Math.sin(angle_x);
		var cosY = Math.cos(angle_y);
		var sinY = Math.sin(angle_y);

		out[0] = cosY;
		out[1] = 0;
		out[2] = -sinY;
		out[3] = 0;
		out[4] = -sinX * sinY;
		out[5] = cosX;
		out[6] = -sinY * cosY;
		out[7] = 0;
		out[8] = cosX * sinY;
		out[9] = sinX;
		out[10] = cosX * cosY;
		out[11] = 0;
		out[12] = 0;
		out[13] = 0;
		out[14] = 0;
		out[15] = 1;
		return out;
	}


	/**
	 * Generates a perspective projection matrix with the given bounds
	 *
	 * @param {mat4} out mat4 frustum matrix will be written into
	 * @param {number} fovy Vertical field of view in radians
	 * @param {number} aspect Aspect ratio. typically viewport width/height
	 * @param {number} near Near bound of the frustum
	 * @param {number} far Far bound of the frustum
	 * @returns {mat4} out
	 */
	static public function perspective(out : Mat4, fovy : Float, aspect : Float, near : Float, far : Float) {
		var f = 1.0 / Math.tan(fovy / 2),
			nf = 1 / (near - far);
		out[0] = f / aspect;
		out[1] = 0;
		out[2] = 0;
		out[3] = 0;
		out[4] = 0;
		out[5] = f;
		out[6] = 0;
		out[7] = 0;
		out[8] = 0;
		out[9] = 0;
		out[10] = (far + near) * nf;
		out[11] = -1;
		out[12] = 0;
		out[13] = 0;
		out[14] = (2 * far * near) * nf;
		out[15] = 0;
		return out;
	}

/*
 * Generates a perspective projection matrix with the given field of view.
 * This is primarily useful for generating projection matrices to be used
 * with the still experiemental WebVR API.
 *
 * @param {mat4} out mat4 frustum matrix will be written into
 * @param {number} fov Object containing the following values: upDegrees, downDegrees, leftDegrees, rightDegrees
 * @param {number} near Near bound of the frustum
 * @param {number} far Far bound of the frustum
 * @returns {mat4} out
 */
// static public function perspectiveFromFieldOfView(out : Mat4, fov : Float, near : Float, far : Float) {
//     var upTan = Math.tan(fov.upDegrees * Math.PI/180.0),
//         downTan = Math.tan(fov.downDegrees * Math.PI/180.0),
//         leftTan = Math.tan(fov.leftDegrees * Math.PI/180.0),
//         rightTan = Math.tan(fov.rightDegrees * Math.PI/180.0),
//         xScale = 2.0 / (leftTan + rightTan),
//         yScale = 2.0 / (upTan + downTan);

//     out[0] = xScale;
//     out[1] = 0.0;
//     out[2] = 0.0;
//     out[3] = 0.0;
//     out[4] = 0.0;
//     out[5] = yScale;
//     out[6] = 0.0;
//     out[7] = 0.0;
//     out[8] = -((leftTan - rightTan) * xScale * 0.5);
//     out[9] = ((upTan - downTan) * yScale * 0.5);
//     out[10] = far / (near - far);
//     out[11] = -1.0;
//     out[12] = 0.0;
//     out[13] = 0.0;
//     out[14] = (far * near) / (near - far);
//     out[15] = 0.0;
//     return out;
// }

	/**
	 * Generates a look-at matrix with the given eye position, focal point, and up axis
	 *
	 * @param {mat4} out mat4 frustum matrix will be written into
	 * @param {vec3} eye Position of the viewer
	 * @param {vec3} center Point the viewer is looking at
	 * @param {vec3} up vec3 pointing up
	 * @returns {mat4} out
	 */
	static public function lookAt(out : Mat4, eye : Vec3, center : Vec3, up : Vec3) {
		var x0, x1, x2, y0, y1, y2, z0, z1, z2, len;

		if (Math.abs(eye.x - center.x) < GLMAT_EPSILON &&
			Math.abs(eye.y - center.y) < GLMAT_EPSILON &&
			Math.abs(eye.z - center.z) < GLMAT_EPSILON) {
			return identity(out);
		}

		z0 = eye.x - center.x;
		z1 = eye.y - center.y;
		z2 = eye.z - center.z;

		len = 1 / Math.sqrt(z0 * z0 + z1 * z1 + z2 * z2);
		z0 *= len;
		z1 *= len;
		z2 *= len;

		x0 = up.y * z2 - up.z * z1;
		x1 = up.z * z0 - up.x * z2;
		x2 = up.x * z1 - up.y * z0;
		len = Math.sqrt(x0 * x0 + x1 * x1 + x2 * x2);
		if (len == 0) {
			x0 = 0;
			x1 = 0;
			x2 = 0;
		} else {
			len = 1 / len;
			x0 *= len;
			x1 *= len;
			x2 *= len;
		}

		y0 = z1 * x2 - z2 * x1;
		y1 = z2 * x0 - z0 * x2;
		y2 = z0 * x1 - z1 * x0;

		len = Math.sqrt(y0 * y0 + y1 * y1 + y2 * y2);
		if (len == 0) {
			y0 = 0;
			y1 = 0;
			y2 = 0;
		} else {
			len = 1 / len;
			y0 *= len;
			y1 *= len;
			y2 *= len;
		}

		out[0] = x0;
		out[1] = y0;
		out[2] = z0;
		out[3] = 0;
		out[4] = x1;
		out[5] = y1;
		out[6] = z1;
		out[7] = 0;
		out[8] = x2;
		out[9] = y2;
		out[10] = z2;
		out[11] = 0;
		out[12] = -(x0 * eye.x + x1 * eye.y + x2 * eye.z);
		out[13] = -(y0 * eye.x + y1 * eye.y + y2 * eye.z);
		out[14] = -(z0 * eye.x + z1 * eye.y + z2 * eye.z);
		out[15] = 1;

		return out;
	}

	/**
	 * Inverts a mat4
	 *
	 * @param {mat4} out the receiving matrix
	 * @param {mat4} a the source matrix
	 * @returns {mat4} out
	 **/
	public static function invert(out : Mat4, a : Mat4) : Mat4 {
		var a00 = a[0], a01 = a[1], a02 = a[2], a03 = a[3],
			a10 = a[4], a11 = a[5], a12 = a[6], a13 = a[7],
			a20 = a[8], a21 = a[9], a22 = a[10], a23 = a[11],
			a30 = a[12], a31 = a[13], a32 = a[14], a33 = a[15],

			b00 = a00 * a11 - a01 * a10,
			b01 = a00 * a12 - a02 * a10,
			b02 = a00 * a13 - a03 * a10,
			b03 = a01 * a12 - a02 * a11,
			b04 = a01 * a13 - a03 * a11,
			b05 = a02 * a13 - a03 * a12,
			b06 = a20 * a31 - a21 * a30,
			b07 = a20 * a32 - a22 * a30,
			b08 = a20 * a33 - a23 * a30,
			b09 = a21 * a32 - a22 * a31,
			b10 = a21 * a33 - a23 * a31,
			b11 = a22 * a33 - a23 * a32,

			// Calculate the determinant
			det = b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06;

		if (det == 0) { 
			return null; 
		}
		det = 1.0 / det;

		out[0] = (a11 * b11 - a12 * b10 + a13 * b09) * det;
		out[1] = (a02 * b10 - a01 * b11 - a03 * b09) * det;
		out[2] = (a31 * b05 - a32 * b04 + a33 * b03) * det;
		out[3] = (a22 * b04 - a21 * b05 - a23 * b03) * det;
		out[4] = (a12 * b08 - a10 * b11 - a13 * b07) * det;
		out[5] = (a00 * b11 - a02 * b08 + a03 * b07) * det;
		out[6] = (a32 * b02 - a30 * b05 - a33 * b01) * det;
		out[7] = (a20 * b05 - a22 * b02 + a23 * b01) * det;
		out[8] = (a10 * b10 - a11 * b08 + a13 * b06) * det;
		out[9] = (a01 * b08 - a00 * b10 - a03 * b06) * det;
		out[10] = (a30 * b04 - a31 * b02 + a33 * b00) * det;
		out[11] = (a21 * b02 - a20 * b04 - a23 * b00) * det;
		out[12] = (a11 * b07 - a10 * b09 - a12 * b06) * det;
		out[13] = (a00 * b09 - a01 * b07 + a02 * b06) * det;
		out[14] = (a31 * b01 - a30 * b03 - a32 * b00) * det;
		out[15] = (a20 * b03 - a21 * b01 + a22 * b00) * det;

		return out;
	}
}


/*


// *
//  * Transpose the values of a mat4
//  *
//  * @param {mat4} out the receiving matrix
//  * @param {mat4} a the source matrix
//  * @returns {mat4} out
 
mat4.transpose = function(out, a) {
	// If we are transposing ourselves we can skip a few steps but have to cache some values
	if (out === a) {
		var a01 = a[1], a02 = a[2], a03 = a[3],
			a12 = a[6], a13 = a[7],
			a23 = a[11];

		out[1] = a[4];
		out[2] = a[8];
		out[3] = a[12];
		out[4] = a01;
		out[6] = a[9];
		out[7] = a[13];
		out[8] = a02;
		out[9] = a12;
		out[11] = a[14];
		out[12] = a03;
		out[13] = a13;
		out[14] = a23;
	} else {
		out[0] = a[0];
		out[1] = a[4];
		out[2] = a[8];
		out[3] = a[12];
		out[4] = a[1];
		out[5] = a[5];
		out[6] = a[9];
		out[7] = a[13];
		out[8] = a[2];
		out[9] = a[6];
		out[10] = a[10];
		out[11] = a[14];
		out[12] = a[3];
		out[13] = a[7];
		out[14] = a[11];
		out[15] = a[15];
	}
	
	return out;
};



// *
//  * Calculates the adjugate of a mat4
//  *
//  * @param {mat4} out the receiving matrix
//  * @param {mat4} a the source matrix
//  * @returns {mat4} out
 
mat4.adjoint = function(out, a) {
	var a00 = a[0], a01 = a[1], a02 = a[2], a03 = a[3],
		a10 = a[4], a11 = a[5], a12 = a[6], a13 = a[7],
		a20 = a[8], a21 = a[9], a22 = a[10], a23 = a[11],
		a30 = a[12], a31 = a[13], a32 = a[14], a33 = a[15];

	out[0]  =  (a11 * (a22 * a33 - a23 * a32) - a21 * (a12 * a33 - a13 * a32) + a31 * (a12 * a23 - a13 * a22));
	out[1]  = -(a01 * (a22 * a33 - a23 * a32) - a21 * (a02 * a33 - a03 * a32) + a31 * (a02 * a23 - a03 * a22));
	out[2]  =  (a01 * (a12 * a33 - a13 * a32) - a11 * (a02 * a33 - a03 * a32) + a31 * (a02 * a13 - a03 * a12));
	out[3]  = -(a01 * (a12 * a23 - a13 * a22) - a11 * (a02 * a23 - a03 * a22) + a21 * (a02 * a13 - a03 * a12));
	out[4]  = -(a10 * (a22 * a33 - a23 * a32) - a20 * (a12 * a33 - a13 * a32) + a30 * (a12 * a23 - a13 * a22));
	out[5]  =  (a00 * (a22 * a33 - a23 * a32) - a20 * (a02 * a33 - a03 * a32) + a30 * (a02 * a23 - a03 * a22));
	out[6]  = -(a00 * (a12 * a33 - a13 * a32) - a10 * (a02 * a33 - a03 * a32) + a30 * (a02 * a13 - a03 * a12));
	out[7]  =  (a00 * (a12 * a23 - a13 * a22) - a10 * (a02 * a23 - a03 * a22) + a20 * (a02 * a13 - a03 * a12));
	out[8]  =  (a10 * (a21 * a33 - a23 * a31) - a20 * (a11 * a33 - a13 * a31) + a30 * (a11 * a23 - a13 * a21));
	out[9]  = -(a00 * (a21 * a33 - a23 * a31) - a20 * (a01 * a33 - a03 * a31) + a30 * (a01 * a23 - a03 * a21));
	out[10] =  (a00 * (a11 * a33 - a13 * a31) - a10 * (a01 * a33 - a03 * a31) + a30 * (a01 * a13 - a03 * a11));
	out[11] = -(a00 * (a11 * a23 - a13 * a21) - a10 * (a01 * a23 - a03 * a21) + a20 * (a01 * a13 - a03 * a11));
	out[12] = -(a10 * (a21 * a32 - a22 * a31) - a20 * (a11 * a32 - a12 * a31) + a30 * (a11 * a22 - a12 * a21));
	out[13] =  (a00 * (a21 * a32 - a22 * a31) - a20 * (a01 * a32 - a02 * a31) + a30 * (a01 * a22 - a02 * a21));
	out[14] = -(a00 * (a11 * a32 - a12 * a31) - a10 * (a01 * a32 - a02 * a31) + a30 * (a01 * a12 - a02 * a11));
	out[15] =  (a00 * (a11 * a22 - a12 * a21) - a10 * (a01 * a22 - a02 * a21) + a20 * (a01 * a12 - a02 * a11));
	return out;
};

// *
//  * Calculates the determinant of a mat4
//  *
//  * @param {mat4} a the source matrix
//  * @returns {number} determinant of a
 
mat4.determinant = function (a) {
	var a00 = a[0], a01 = a[1], a02 = a[2], a03 = a[3],
		a10 = a[4], a11 = a[5], a12 = a[6], a13 = a[7],
		a20 = a[8], a21 = a[9], a22 = a[10], a23 = a[11],
		a30 = a[12], a31 = a[13], a32 = a[14], a33 = a[15],

		b00 = a00 * a11 - a01 * a10,
		b01 = a00 * a12 - a02 * a10,
		b02 = a00 * a13 - a03 * a10,
		b03 = a01 * a12 - a02 * a11,
		b04 = a01 * a13 - a03 * a11,
		b05 = a02 * a13 - a03 * a12,
		b06 = a20 * a31 - a21 * a30,
		b07 = a20 * a32 - a22 * a30,
		b08 = a20 * a33 - a23 * a30,
		b09 = a21 * a32 - a22 * a31,
		b10 = a21 * a33 - a23 * a31,
		b11 = a22 * a33 - a23 * a32;

	// Calculate the determinant
	return b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06;
};


// *
//  * Rotates a mat4 by the given angle
//  *
//  * @param {mat4} out the receiving matrix
//  * @param {mat4} a the matrix to rotate
//  * @param {number} rad the angle to rotate the matrix by
//  * @param {vec3} axis the axis to rotate around
//  * @returns {mat4} out
 
mat4.rotate = function (out, a, rad, axis) {
	var x = axis[0], y = axis[1], z = axis[2],
		len = Math.sqrt(x * x + y * y + z * z),
		s, c, t,
		a00, a01, a02, a03,
		a10, a11, a12, a13,
		a20, a21, a22, a23,
		b00, b01, b02,
		b10, b11, b12,
		b20, b21, b22;

	if (Math.abs(len) < GLMAT_EPSILON) { return null; }
	
	len = 1 / len;
	x *= len;
	y *= len;
	z *= len;

	s = Math.sin(rad);
	c = Math.cos(rad);
	t = 1 - c;

	a00 = a[0]; a01 = a[1]; a02 = a[2]; a03 = a[3];
	a10 = a[4]; a11 = a[5]; a12 = a[6]; a13 = a[7];
	a20 = a[8]; a21 = a[9]; a22 = a[10]; a23 = a[11];

	// Construct the elements of the rotation matrix
	b00 = x * x * t + c; b01 = y * x * t + z * s; b02 = z * x * t - y * s;
	b10 = x * y * t - z * s; b11 = y * y * t + c; b12 = z * y * t + x * s;
	b20 = x * z * t + y * s; b21 = y * z * t - x * s; b22 = z * z * t + c;

	// Perform rotation-specific matrix multiplication
	out[0] = a00 * b00 + a10 * b01 + a20 * b02;
	out[1] = a01 * b00 + a11 * b01 + a21 * b02;
	out[2] = a02 * b00 + a12 * b01 + a22 * b02;
	out[3] = a03 * b00 + a13 * b01 + a23 * b02;
	out[4] = a00 * b10 + a10 * b11 + a20 * b12;
	out[5] = a01 * b10 + a11 * b11 + a21 * b12;
	out[6] = a02 * b10 + a12 * b11 + a22 * b12;
	out[7] = a03 * b10 + a13 * b11 + a23 * b12;
	out[8] = a00 * b20 + a10 * b21 + a20 * b22;
	out[9] = a01 * b20 + a11 * b21 + a21 * b22;
	out[10] = a02 * b20 + a12 * b21 + a22 * b22;
	out[11] = a03 * b20 + a13 * b21 + a23 * b22;

	if (a !== out) { // If the source and destination differ, copy the unchanged last row
		out[12] = a[12];
		out[13] = a[13];
		out[14] = a[14];
		out[15] = a[15];
	}
	return out;
};

// *
//  * Rotates a matrix by the given angle around the X axis
//  *
//  * @param {mat4} out the receiving matrix
//  * @param {mat4} a the matrix to rotate
//  * @param {number} rad the angle to rotate the matrix by
//  * @returns {mat4} out
 
mat4.rotateX = function (out, a, rad) {
	var s = Math.sin(rad),
		c = Math.cos(rad),
		a10 = a[4],
		a11 = a[5],
		a12 = a[6],
		a13 = a[7],
		a20 = a[8],
		a21 = a[9],
		a22 = a[10],
		a23 = a[11];

	if (a !== out) { // If the source and destination differ, copy the unchanged rows
		out[0]  = a[0];
		out[1]  = a[1];
		out[2]  = a[2];
		out[3]  = a[3];
		out[12] = a[12];
		out[13] = a[13];
		out[14] = a[14];
		out[15] = a[15];
	}

	// Perform axis-specific matrix multiplication
	out[4] = a10 * c + a20 * s;
	out[5] = a11 * c + a21 * s;
	out[6] = a12 * c + a22 * s;
	out[7] = a13 * c + a23 * s;
	out[8] = a20 * c - a10 * s;
	out[9] = a21 * c - a11 * s;
	out[10] = a22 * c - a12 * s;
	out[11] = a23 * c - a13 * s;
	return out;
};

// *
//  * Rotates a matrix by the given angle around the Y axis
//  *
//  * @param {mat4} out the receiving matrix
//  * @param {mat4} a the matrix to rotate
//  * @param {number} rad the angle to rotate the matrix by
//  * @returns {mat4} out
 
mat4.rotateY = function (out, a, rad) {
	var s = Math.sin(rad),
		c = Math.cos(rad),
		a00 = a[0],
		a01 = a[1],
		a02 = a[2],
		a03 = a[3],
		a20 = a[8],
		a21 = a[9],
		a22 = a[10],
		a23 = a[11];

	if (a !== out) { // If the source and destination differ, copy the unchanged rows
		out[4]  = a[4];
		out[5]  = a[5];
		out[6]  = a[6];
		out[7]  = a[7];
		out[12] = a[12];
		out[13] = a[13];
		out[14] = a[14];
		out[15] = a[15];
	}

	// Perform axis-specific matrix multiplication
	out[0] = a00 * c - a20 * s;
	out[1] = a01 * c - a21 * s;
	out[2] = a02 * c - a22 * s;
	out[3] = a03 * c - a23 * s;
	out[8] = a00 * s + a20 * c;
	out[9] = a01 * s + a21 * c;
	out[10] = a02 * s + a22 * c;
	out[11] = a03 * s + a23 * c;
	return out;
};

// *
//  * Rotates a matrix by the given angle around the Z axis
//  *
//  * @param {mat4} out the receiving matrix
//  * @param {mat4} a the matrix to rotate
//  * @param {number} rad the angle to rotate the matrix by
//  * @returns {mat4} out
 
mat4.rotateZ = function (out, a, rad) {
	var s = Math.sin(rad),
		c = Math.cos(rad),
		a00 = a[0],
		a01 = a[1],
		a02 = a[2],
		a03 = a[3],
		a10 = a[4],
		a11 = a[5],
		a12 = a[6],
		a13 = a[7];

	if (a !== out) { // If the source and destination differ, copy the unchanged last row
		out[8]  = a[8];
		out[9]  = a[9];
		out[10] = a[10];
		out[11] = a[11];
		out[12] = a[12];
		out[13] = a[13];
		out[14] = a[14];
		out[15] = a[15];
	}

	// Perform axis-specific matrix multiplication
	out[0] = a00 * c + a10 * s;
	out[1] = a01 * c + a11 * s;
	out[2] = a02 * c + a12 * s;
	out[3] = a03 * c + a13 * s;
	out[4] = a10 * c - a00 * s;
	out[5] = a11 * c - a01 * s;
	out[6] = a12 * c - a02 * s;
	out[7] = a13 * c - a03 * s;
	return out;
};

// *
//  * Creates a matrix from a quaternion rotation and vector translation
//  * This is equivalent to (but much faster than):
//  *
//  *     mat4.identity(dest);
//  *     mat4.translate(dest, vec);
//  *     var quatMat = mat4.create();
//  *     quat4.toMat4(quat, quatMat);
//  *     mat4.multiply(dest, quatMat);
//  *
//  * @param {mat4} out mat4 receiving operation result
//  * @param {quat4} q Rotation quaternion
//  * @param {vec3} v Translation vector
//  * @returns {mat4} out
 
mat4.fromRotationTranslation = function (out, q, v) {
	// Quaternion math
	var x = q[0], y = q[1], z = q[2], w = q[3],
		x2 = x + x,
		y2 = y + y,
		z2 = z + z,

		xx = x * x2,
		xy = x * y2,
		xz = x * z2,
		yy = y * y2,
		yz = y * z2,
		zz = z * z2,
		wx = w * x2,
		wy = w * y2,
		wz = w * z2;

	out[0] = 1 - (yy + zz);
	out[1] = xy + wz;
	out[2] = xz - wy;
	out[3] = 0;
	out[4] = xy - wz;
	out[5] = 1 - (xx + zz);
	out[6] = yz + wx;
	out[7] = 0;
	out[8] = xz + wy;
	out[9] = yz - wx;
	out[10] = 1 - (xx + yy);
	out[11] = 0;
	out[12] = v[0];
	out[13] = v[1];
	out[14] = v[2];
	out[15] = 1;
	
	return out;
};

mat4.fromQuat = function (out, q) {
	var x = q[0], y = q[1], z = q[2], w = q[3],
		x2 = x + x,
		y2 = y + y,
		z2 = z + z,

		xx = x * x2,
		yx = y * x2,
		yy = y * y2,
		zx = z * x2,
		zy = z * y2,
		zz = z * z2,
		wx = w * x2,
		wy = w * y2,
		wz = w * z2;

	out[0] = 1 - yy - zz;
	out[1] = yx + wz;
	out[2] = zx - wy;
	out[3] = 0;

	out[4] = yx - wz;
	out[5] = 1 - xx - zz;
	out[6] = zy + wx;
	out[7] = 0;

	out[8] = zx + wy;
	out[9] = zy - wx;
	out[10] = 1 - xx - yy;
	out[11] = 0;

	out[12] = 0;
	out[13] = 0;
	out[14] = 0;
	out[15] = 1;

	return out;
};



// *
//  * Returns a string representation of a mat4
//  *
//  * @param {mat4} mat matrix to represent as a string
//  * @returns {String} string representation of the matrix
 
mat4.str = function (a) {
	return 'mat4(' + a[0] + ', ' + a[1] + ', ' + a[2] + ', ' + a[3] + ', ' +
					a[4] + ', ' + a[5] + ', ' + a[6] + ', ' + a[7] + ', ' +
					a[8] + ', ' + a[9] + ', ' + a[10] + ', ' + a[11] + ', ' + 
					a[12] + ', ' + a[13] + ', ' + a[14] + ', ' + a[15] + ')';
};

// /**
//  * Returns Frobenius norm of a mat4
//  *
//  * @param {mat4} a the matrix to calculate Frobenius norm of
//  * @returns {number} Frobenius norm
 
mat4.frob = function (a) {
	return(Math.sqrt(Math.pow(a[0], 2) + Math.pow(a[1], 2) + Math.pow(a[2], 2) + Math.pow(a[3], 2) + Math.pow(a[4], 2) + Math.pow(a[5], 2) + Math.pow(a[6], 2) + Math.pow(a[7], 2) + Math.pow(a[8], 2) + Math.pow(a[9], 2) + Math.pow(a[10], 2) + Math.pow(a[11], 2) + Math.pow(a[12], 2) + Math.pow(a[13], 2) + Math.pow(a[14], 2) + Math.pow(a[15], 2) ))
};


if(typeof(exports) !== 'undefined') {
	exports.mat4 = mat4;
}
*/