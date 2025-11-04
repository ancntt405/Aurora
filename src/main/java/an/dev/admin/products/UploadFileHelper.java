package an.dev.admin.products;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;
import java.io.File;
import java.util.List;

public class UploadFileHelper {
    public static List<String> uploadFile(String uploadDir, HttpServletRequest request) {
        try {
            List<String> saved = new java.util.ArrayList<>();
            String realUploadPath = request.getServletContext().getRealPath("/" + uploadDir);
            File uploadPath = new File(realUploadPath);
            if (!uploadPath.exists()) uploadPath.mkdirs();

            for (Part part : request.getParts()) {
                String submitted = part.getSubmittedFileName();
                if (submitted == null || submitted.isEmpty()) continue;

                String original = new File(submitted).getName();
                String fileName = System.currentTimeMillis() + "_" + original;

                File dest = new File(uploadPath, fileName);
                System.out.println("Saving file to: " + dest.getAbsolutePath());
                part.write(dest.getAbsolutePath());
                saved.add(fileName);
            }
            return saved;
        } catch (Exception e) {
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }

    public static List<String> uploadFilesByField(String uploadDir, HttpServletRequest request, String fieldName) {
        try {
            List<String> saved = new java.util.ArrayList<>();
            String realUploadPath = request.getServletContext().getRealPath("/" + uploadDir);
            File uploadPath = new File(realUploadPath);
            if (!uploadPath.exists()) uploadPath.mkdirs();

            for (Part part : request.getParts()) {
                if (!fieldName.equals(part.getName())) continue;
                String submitted = part.getSubmittedFileName();
                if (submitted == null || submitted.isEmpty()) continue;

                String original = new File(submitted).getName();
                String fileName = System.currentTimeMillis() + "_" + original;

                File dest = new File(uploadPath, fileName);
                System.out.println("Saving file to: " + dest.getAbsolutePath());
                part.write(dest.getAbsolutePath());
                saved.add(fileName);
            }
            return saved;
        } catch (Exception e) {
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }

    public static String uploadSingleFile(String uploadDir, Part imagePart, HttpServletRequest request) {
        if (imagePart == null || imagePart.getSize() == 0) return "";

        try {
            String original = imagePart.getSubmittedFileName();
            if (original == null || original.isEmpty()) return "";
            original = new File(original).getName();
            String fileName = System.currentTimeMillis() + "_" + original;

            String realUploadPath = request.getServletContext().getRealPath("/" + uploadDir);
            File uploadPath = new File(realUploadPath);
            if (!uploadPath.exists()) uploadPath.mkdirs();

            File dest = new File(uploadPath, fileName);
            System.out.println("Saving file to: " + dest.getAbsolutePath());
            imagePart.write(dest.getAbsolutePath());
            return fileName;
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }
}
