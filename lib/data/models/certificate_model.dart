/// The type of certificate asset.
enum CertificateType {
  /// Certificate is stored as an image (PNG/JPG) in assets.
  image,

  /// Certificate is stored as a PDF in assets.
  pdf,
}

/// Data model for a certificate in the portfolio.
class CertificateModel {
  /// Certificate title / name.
  final String title;

  /// Issuing organization.
  final String issuer;

  /// Date of issuance (display string, e.g., 'March 2024').
  final String date;

  /// Path to the certificate asset (image or PDF).
  /// For images: 'assets/images/certificates/cert_name.png'
  /// For PDFs: 'assets/pdfs/certificates/cert_name.pdf'
  final String assetPath;

  /// Whether this certificate is an image or a PDF.
  final CertificateType type;

  const CertificateModel({
    required this.title,
    required this.issuer,
    required this.date,
    required this.assetPath,
    required this.type,
  });
}
