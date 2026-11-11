import { readFile } from "node:fs/promises";

const inheritedProject = "datedawn";

async function readJson(path) {
  try {
    return JSON.parse(await readFile(path, "utf8"));
  } catch (error) {
    if (error.code === "ENOENT") return null;
    throw error;
  }
}

const firebaseRc = await readJson(".firebaserc");
const optionsSource = await readFile("lib/firebase_options.dart", "utf8");
const configuredProjects = [...optionsSource.matchAll(/projectId:\s*'([^']+)'/g)].map(
  (match) => match[1],
);
const firebaseProject = firebaseRc?.projects?.default;
const uniqueProjects = new Set(configuredProjects);
const ready =
  firebaseProject &&
  firebaseProject !== inheritedProject &&
  uniqueProjects.size === 1 &&
  uniqueProjects.has(firebaseProject);

console.log("\nBite Brigade Firebase configuration\n" + "=".repeat(36));
if (!ready) {
  console.log("[FAIL] A dedicated Firebase project is not configured.");
  console.log(
    "This copy still contains the inherited Date Dawn project or has " +
      "mismatched platform settings.",
  );
  console.log(
    "Create a separate Firebase project, then run `flutterfire configure " +
      "--project=your-table-talk-project-id` and update .firebaserc to the " +
      "same project. No network probes were made.",
  );
  process.exitCode = 1;
} else {
  console.log(`[OK] All Flutter platform options and .firebaserc target ${firebaseProject}.`);
  console.log(
    "This checks local project configuration only. Enable Firebase " +
      "Authentication and Cloud Firestore and deploy the reviewed rules " +
      "before using a live backend.",
  );
}
