package com.example.morganjoystick

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.PointF
import android.util.AttributeSet
import android.view.MotionEvent
import android.view.View
import kotlin.math.*

@SuppressLint("ClickableViewAccessibility")
class JoystickView @JvmOverloads constructor(context: Context, attrs: AttributeSet? = null, defStyleAttr: Int = 0) : View(context, attrs, defStyleAttr) {
    // Constants
    private val DEFAULT_RADIUS = 300f
    private val DEFAULT_COLOR = Color.BLACK
    private val DEFAULT_THUMB_RADIUS = 130f
    private val DEFAULT_THUMB_COLOR = Color.RED

    // Paint objects
    private val circlePaint = Paint().apply {
        color = DEFAULT_COLOR
        style = Paint.Style.FILL
    }
    private val thumbPaint = Paint().apply {
        color = DEFAULT_THUMB_COLOR
        style = Paint.Style.FILL
    }

    // Circle properties
    private var radius = DEFAULT_RADIUS
    private val center = PointF()

    // Thumb properties
    private var thumbRadius = DEFAULT_THUMB_RADIUS
    private val thumbPosition = PointF()

    // Listener
    private var listener: ((angle: Float, strength: Float) -> Unit)? = null

    init {
        // Set up touch listener
        setOnTouchListener { _, event ->
            // Calculate distance and angle from center
            val distance = sqrt((event.x - center.x).pow(2) + (event.y - center.y).pow(2))
            val angle = (atan2(event.y - center.y, event.x - center.x) * 180 / PI).toFloat()

            when (event.action) {
                MotionEvent.ACTION_DOWN, MotionEvent.ACTION_MOVE -> {
                    // Clamp distance to maximum radius
                    val clampedDistance = min(distance, radius)

                    // Calculate thumb position based on angle and clamped distance
                    thumbPosition.x = (center.x + clampedDistance * cos(angle * PI / 180)).toFloat()
                    thumbPosition.y = (center.y + clampedDistance * sin(angle * PI / 180)).toFloat()

                    // Call listener with angle and normalized strength
                    listener?.invoke(angle, clampedDistance / radius)
                    invalidate()
                }

                MotionEvent.ACTION_UP -> {
                    // Reset thumb position
                    thumbPosition.x = center.x
                    thumbPosition.y = center.y

                    // Call listener with zero angle and zero strength
                    listener?.invoke(0f, 0f)
                    invalidate()
                }
            }
            true
        }
    }

    override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
        // Calculate desired size based on radius
        val desiredWidth = (radius * 2).toInt() + paddingLeft + paddingRight
        val desiredHeight = (radius * 2).toInt() + paddingTop + paddingBottom

        // Calculate actual size based on spec
        val width = resolveSize(desiredWidth, widthMeasureSpec)
        val height = resolveSize(desiredHeight, heightMeasureSpec)

        // Take the smaller of the two sizes as the final size
        val size = min(width, height)

        // Set actual size and center point
        setMeasuredDimension(size, size)
        center.set(size / 2f, size / 2f)
    }

    override fun onDraw(canvas: Canvas) {
        // Draw circle
        canvas.drawCircle(center.x, center.y, radius, circlePaint)

        // Draw thumb
        canvas.drawCircle(thumbPosition.x, thumbPosition.y, thumbRadius, thumbPaint)
    }

    fun setOnMoveListener(listener: (angle: Float, strength: Float) -> Unit) {
        this.listener = listener
    }
    fun setThumbRadius(radius: Float) {
        this.thumbRadius = radius
        invalidate()
    }

    fun setCircleRadius(radius: Float) {
        this.radius = radius
        requestLayout()
        invalidate()
    }

    fun setThumbColor(color: Int) {
        thumbPaint.color = color
        invalidate()
    }

    fun setCircleColor(color: Int) {
        circlePaint.color = color
        invalidate()
    }

}
