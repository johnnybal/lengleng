package com.example.lengleng.theme

import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.runtime.*
import androidx.compose.ui.graphics.Color
import com.example.lengleng.services.Theme
import com.example.lengleng.services.ThemeService
import com.google.firebase.auth.FirebaseAuth

private val LightDefaultColors = lightColorScheme(
    primary = Color(0xFF6200EE),
    onPrimary = Color.White,
    primaryContainer = Color(0xFFE8DEF8),
    onPrimaryContainer = Color(0xFF21005D),
    secondary = Color(0xFF625B71),
    onSecondary = Color.White,
    secondaryContainer = Color(0xFFE8DEF8),
    onSecondaryContainer = Color(0xFF1D192B),
    tertiary = Color(0xFF7D5260),
    onTertiary = Color.White,
    tertiaryContainer = Color(0xFFFFD8E4),
    onTertiaryContainer = Color(0xFF31111D),
    background = Color(0xFFFFFBFE),
    onBackground = Color(0xFF1C1B1F),
    surface = Color(0xFFFFFBFE),
    onSurface = Color(0xFF1C1B1F),
    surfaceVariant = Color(0xFFE7E0EC),
    onSurfaceVariant = Color(0xFF49454F),
    outline = Color(0xFF79747E),
    outlineVariant = Color(0xFFCAC4D0)
)

private val DarkDefaultColors = darkColorScheme(
    primary = Color(0xFFD0BCFF),
    onPrimary = Color(0xFF381E72),
    primaryContainer = Color(0xFF4F378B),
    onPrimaryContainer = Color(0xFFEADDFF),
    secondary = Color(0xFFCCC2DC),
    onSecondary = Color(0xFF332D41),
    secondaryContainer = Color(0xFF4A4458),
    onSecondaryContainer = Color(0xFFE8DEF8),
    tertiary = Color(0xFFEFB8C8),
    onTertiary = Color(0xFF492532),
    tertiaryContainer = Color(0xFF633B48),
    onTertiaryContainer = Color(0xFFFFD8E4),
    background = Color(0xFF1C1B1F),
    onBackground = Color(0xFFE6E1E5),
    surface = Color(0xFF1C1B1F),
    onSurface = Color(0xFFE6E1E5),
    surfaceVariant = Color(0xFF49454F),
    onSurfaceVariant = Color(0xFFCAC4D0),
    outline = Color(0xFF938F99),
    outlineVariant = Color(0xFF49454F)
)

@Composable
fun AppTheme(
    themeService: ThemeService,
    darkTheme: Boolean = false,
    content: @Composable () -> Unit
) {
    var currentTheme by remember { mutableStateOf<Theme?>(null) }
    val userId = FirebaseAuth.getInstance().currentUser?.uid
    
    LaunchedEffect(userId) {
        if (userId != null) {
            themeService.getUserTheme(userId) { theme ->
                currentTheme = theme
            }
        }
    }
    
    val colorScheme = when {
        currentTheme != null -> lightColorScheme(
            primary = currentTheme!!.primaryColor,
            secondary = currentTheme!!.secondaryColor,
            tertiary = currentTheme!!.tertiaryColor
        )
        darkTheme -> DarkDefaultColors
        else -> LightDefaultColors
    }
    
    MaterialTheme(
        colorScheme = colorScheme,
        content = content
    )
} 