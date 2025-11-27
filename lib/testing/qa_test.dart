// lib/testing/qa_test.dart
/*
QA / Testing checklist (Anggota 5)

1. Form validation - Login:
   - Email empty -> shows "Email wajib diisi"
   - Email invalid -> shows "Email tidak valid"
   - Email not domain kampus -> shows "Gunakan domain kampus (.ac.id)"
   - Password < 6 -> shows "Minimal 6 karakter"

2. Form validation - Register:
   - NIM required
   - Name required
   - Email domain
   - Password length

3. ListView safety:
   - HomeScreen should show proper message or simply show empty list without crash.
   - Recommendations: use StreamBuilder or check empty before ListView.builder.

4. Checkout Logic Trap:
   - Use NIM '141' -> last digit 1 odd -> discount = subtotal * 0.05
   - Use an even NIM -> shipping free (0) per spec (adjust shipping logic if your product requires shipping fee).

5. Firestore transaction:
   - Run checkoutbac and ensure stock >= qty checks pass.
   - Ensure Transaction doc created and Stocks decremented atomically.

6. Navigation:
   - After successful login -> pushReplacement to '/home'
   - After register -> pushReplacement to '/login'
*/
